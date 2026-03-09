//
//  CameraManager.swift
//  Finora
//
//  Handles camera capture for receipt scanning and QR code detection
//  Uses AVFoundation for photo capture and barcode scanning
//

import AVFoundation
import UIKit
import SwiftUI

// MARK: - Scan Mode

enum ScanMode {
    case receipt
    case qrCode
}

@MainActor
class CameraManager: NSObject, ObservableObject {

    // MARK: - Published Properties

    @Published var permissionStatus: AVAuthorizationStatus = .notDetermined
    @Published var capturedImage: UIImage?
    @Published var scannedQRCode: String?
    @Published var isSessionRunning = false
    @Published var error: CameraError?
    @Published var scanMode: ScanMode = .receipt

    // MARK: - Camera Session

    let captureSession = AVCaptureSession()
    private var photoOutput = AVCapturePhotoOutput()
    private var metadataOutput = AVCaptureMetadataOutput()
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

        // Add metadata output for QR codes
        metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417, .code128, .code39]
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

    // MARK: - Mode Switching

    func setScanMode(_ mode: ScanMode) {
        scanMode = mode
        scannedQRCode = nil
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
        scannedQRCode = nil
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

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension CameraManager: AVCaptureMetadataOutputObjectsDelegate {
    nonisolated func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        Task { @MainActor in
            // Only process QR codes when in QR mode
            guard self.scanMode == .qrCode else { return }

            guard let metadataObject = metadataObjects.first,
                  let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue else {
                return
            }

            // Haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()

            self.scannedQRCode = stringValue
        }
    }
}

// MARK: - Camera Preview View

struct CameraPreviewView: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> CameraPreviewUIView {
        let view = CameraPreviewUIView()
        view.session = session
        return view
    }

    func updateUIView(_ uiView: CameraPreviewUIView, context: Context) {
        // Session is already set, layout will be handled by the view itself
    }
}

// Custom UIView that properly handles preview layer sizing
class CameraPreviewUIView: UIView {
    var session: AVCaptureSession? {
        didSet {
            if let session = session {
                previewLayer.session = session
            }
        }
    }

    private var previewLayer: AVCaptureVideoPreviewLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPreviewLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPreviewLayer()
    }

    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(previewLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Update preview layer frame whenever the view's bounds change
        previewLayer.frame = bounds
    }
}
