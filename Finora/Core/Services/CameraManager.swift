//
//  CameraManager.swift
//  Finora
//
//  Handles camera capture for receipt scanning
//  Uses AVFoundation for photo capture
//

import AVFoundation
import UIKit
import SwiftUI

@MainActor
class CameraManager: NSObject, ObservableObject {

    // MARK: - Published Properties

    @Published var permissionStatus: AVAuthorizationStatus = .notDetermined
    @Published var capturedImage: UIImage?
    @Published var isSessionRunning = false
    @Published var error: CameraError?

    // MARK: - Camera Session

    let captureSession = AVCaptureSession()
    private var photoOutput = AVCapturePhotoOutput()
    private var currentCameraPosition: AVCaptureDevice.Position = .back

    // MARK: - Initialization

    override init() {
        super.init()
        checkPermission()
    }

    // MARK: - Permission Handling

    func checkPermission() {
        permissionStatus = AVCaptureDevice.authorizationStatus(for: .video)
    }

    func requestPermission() async -> Bool {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        await MainActor.run {
            permissionStatus = granted ? .authorized : .denied
        }
        return granted
    }

    // MARK: - Session Setup

    func setupSession() throws {
        guard permissionStatus == .authorized else {
            throw CameraError.notAuthorized
        }

        captureSession.beginConfiguration()
        captureSession.sessionPreset = .photo

        // Remove existing inputs
        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }

        // Remove existing outputs
        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }

        // Add camera input
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            captureSession.commitConfiguration()
            throw CameraError.cameraUnavailable
        }

        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            } else {
                captureSession.commitConfiguration()
                throw CameraError.cameraUnavailable
            }
        } catch {
            captureSession.commitConfiguration()
            throw CameraError.cameraUnavailable
        }

        // Add photo output
        photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            captureSession.commitConfiguration()
            throw CameraError.cameraUnavailable
        }

        captureSession.commitConfiguration()
    }

    func startSession() {
        guard !captureSession.isRunning else { return }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
            DispatchQueue.main.async {
                self?.isSessionRunning = true
            }
        }
    }

    func stopSession() {
        guard captureSession.isRunning else { return }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.stopRunning()
            DispatchQueue.main.async {
                self?.isSessionRunning = false
            }
        }
    }

    // MARK: - Capture Photo

    func capturePhoto() {
        let settings = AVCapturePhotoSettings()

        // Enable flash if available
        if photoOutput.supportedFlashModes.contains(.auto) {
            settings.flashMode = .auto
        }

        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    // MARK: - Reset

    func reset() {
        capturedImage = nil
        error = nil
    }

    // MARK: - Error Types

    enum CameraError: LocalizedError {
        case notAuthorized
        case cameraUnavailable
        case captureFailed

        var errorDescription: String? {
            switch self {
            case .notAuthorized:
                return "Camera access not authorized. Please enable camera access in Settings."
            case .cameraUnavailable:
                return "Camera not available on this device."
            case .captureFailed:
                return "Failed to capture photo. Please try again."
            }
        }
    }
}

// MARK: - AVCapturePhotoCaptureDelegate

extension CameraManager: AVCapturePhotoCaptureDelegate {
    nonisolated func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        Task { @MainActor in
            if error != nil {
                self.error = .captureFailed
                return
            }

            guard let imageData = photo.fileDataRepresentation(),
                  let image = UIImage(data: imageData) else {
                self.error = .captureFailed
                return
            }

            self.capturedImage = image
        }
    }
}

// MARK: - Camera Preview View

struct CameraPreviewView: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)

        context.coordinator.previewLayer = previewLayer

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.previewLayer?.frame = uiView.bounds
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var previewLayer: AVCaptureVideoPreviewLayer?
    }
}
