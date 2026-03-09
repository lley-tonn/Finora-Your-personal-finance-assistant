//
//  ReceiptScannerView.swift
//  Finora
//
//  Camera capture for receipt scanning and QR code detection
//  Supports camera capture, photo library selection, and QR scanning
//

import SwiftUI
import PhotosUI
import UIKit

struct ReceiptScannerView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var viewModel = ExpenseViewModel()
    @Environment(\.dismiss) private var dismiss

    // Photo Library
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showPhotoLibrary = false

    // Navigation
    @State private var showPreview = false

    // UI State
    @State private var isProcessing = false
    @State private var headerOpacity: Double = 0
    @State private var controlsOpacity: Double = 0

    // QR Code
    @State private var showQRResult = false

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            switch cameraManager.permissionStatus {
            case .authorized:
                cameraView
            case .notDetermined:
                permissionRequestView
            case .denied, .restricted:
                permissionDeniedView
            @unknown default:
                permissionRequestView
            }

            // Loading Overlay
            if isProcessing {
                processingOverlay
            }
        }
        .navigationBarBackButtonHidden()
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            animateAppearance()
        }
        .onChange(of: cameraManager.capturedImage) { image in
            if let image = image {
                processImage(image)
            }
        }
        .onChange(of: cameraManager.scannedQRCode) { qrCode in
            if let qrCode = qrCode {
                processQRCode(qrCode)
            }
        }
        .onChange(of: selectedPhotoItem) { item in
            Task {
                if let item = item,
                   let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    processImage(image)
                }
            }
        }
        .navigationDestination(isPresented: $showPreview) {
            ReceiptPreviewView(viewModel: viewModel)
        }
        .alert("QR Code Detected", isPresented: $showQRResult) {
            Button("Use This") {
                if let qrCode = cameraManager.scannedQRCode {
                    parseQRCodeData(qrCode)
                }
            }
            Button("Scan Again", role: .cancel) {
                cameraManager.scannedQRCode = nil
            }
        } message: {
            Text(cameraManager.scannedQRCode ?? "")
        }
    }

    // MARK: - Camera View

    private var cameraView: some View {
        ZStack {
            // Camera Preview
            CameraPreviewView(session: cameraManager.captureSession)
                .ignoresSafeArea()
                .onAppear {
                    setupCamera()
                }
                .onDisappear {
                    cameraManager.stopSession()
                }

            // Overlay
            VStack {
                // Header
                header
                    .opacity(headerOpacity)
                    .padding(.top, 60)

                // Mode Toggle
                modeToggle
                    .padding(.top, 16)

                Spacer()

                // Guide Frame (different for receipt vs QR)
                if cameraManager.scanMode == .receipt {
                    receiptGuideFrame
                } else {
                    qrCodeGuideFrame
                }

                Spacer()

                // Controls
                cameraControls
                    .opacity(controlsOpacity)
                    .padding(.bottom, 40)
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 8) {
            Text(cameraManager.scanMode == .receipt ? "Scan Receipt" : "Scan QR Code")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)

            Text(cameraManager.scanMode == .receipt
                 ? "Position receipt within the frame"
                 : "Point camera at QR code")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white.opacity(0.7))
        }
    }

    // MARK: - Mode Toggle

    private var modeToggle: some View {
        HStack(spacing: 0) {
            // Receipt Mode
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    cameraManager.setScanMode(.receipt)
                }
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "doc.text.viewfinder")
                        .font(.system(size: 14, weight: .medium))
                    Text("Receipt")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(cameraManager.scanMode == .receipt ? .white : .white.opacity(0.6))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    cameraManager.scanMode == .receipt
                        ? Color.finoraAIAccent
                        : Color.clear
                )
                .cornerRadius(20)
            }

            // QR Code Mode
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    cameraManager.setScanMode(.qrCode)
                }
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 14, weight: .medium))
                    Text("QR Code")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(cameraManager.scanMode == .qrCode ? .white : .white.opacity(0.6))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    cameraManager.scanMode == .qrCode
                        ? Color.finoraAIAccent
                        : Color.clear
                )
                .cornerRadius(20)
            }
        }
        .padding(4)
        .background(Color.white.opacity(0.15))
        .cornerRadius(24)
    }

    // MARK: - Receipt Guide Frame

    private var receiptGuideFrame: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color.finoraAIAccent, lineWidth: 3)
            .frame(width: 280, height: 400)
            .overlay(
                // Corner accents
                ZStack {
                    // Top-left
                    cornerAccent(rotation: 0)
                        .position(x: 20, y: 20)

                    // Top-right
                    cornerAccent(rotation: 90)
                        .position(x: 260, y: 20)

                    // Bottom-left
                    cornerAccent(rotation: 270)
                        .position(x: 20, y: 380)

                    // Bottom-right
                    cornerAccent(rotation: 180)
                        .position(x: 260, y: 380)
                }
            )
    }

    // MARK: - QR Code Guide Frame

    private var qrCodeGuideFrame: some View {
        ZStack {
            // Scanning area
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.finoraAIAccent, lineWidth: 3)
                .frame(width: 250, height: 250)

            // Corner accents
            ZStack {
                cornerAccent(rotation: 0)
                    .position(x: 20, y: 20)

                cornerAccent(rotation: 90)
                    .position(x: 230, y: 20)

                cornerAccent(rotation: 270)
                    .position(x: 20, y: 230)

                cornerAccent(rotation: 180)
                    .position(x: 230, y: 230)
            }
            .frame(width: 250, height: 250)

            // Scanning animation line
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.clear, Color.finoraAIAccent, Color.clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 200, height: 2)
                .offset(y: -50)
        }
    }

    private func cornerAccent(rotation: Double) -> some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 20))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 20, y: 0))
        }
        .stroke(Color.finoraAIAccent, lineWidth: 4)
        .frame(width: 20, height: 20)
        .rotationEffect(.degrees(rotation))
    }

    // MARK: - Camera Controls

    private var cameraControls: some View {
        HStack(spacing: 40) {
            // Photo Library Button
            PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 56, height: 56)

                    Image(systemName: "photo.on.rectangle")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white)
                }
            }

            // Capture Button (only show for receipt mode)
            if cameraManager.scanMode == .receipt {
                Button(action: {
                    cameraManager.capturePhoto()
                }) {
                    ZStack {
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                            .frame(width: 76, height: 76)

                        Circle()
                            .fill(Color.white)
                            .frame(width: 64, height: 64)
                    }
                }
            } else {
                // QR Mode indicator
                ZStack {
                    Circle()
                        .stroke(Color.finoraAIAccent, lineWidth: 4)
                        .frame(width: 76, height: 76)

                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(.finoraAIAccent)
                }
            }

            // QR Code Button (visual indicator, mode already handled by toggle)
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    cameraManager.setScanMode(cameraManager.scanMode == .qrCode ? .receipt : .qrCode)
                }
            }) {
                ZStack {
                    Circle()
                        .fill(cameraManager.scanMode == .qrCode ? Color.finoraAIAccent : Color.white.opacity(0.2))
                        .frame(width: 56, height: 56)

                    Image(systemName: "qrcode")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white)
                }
            }
        }
    }

    // MARK: - Permission Request View

    private var permissionRequestView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "camera.fill")
                .font(.system(size: 64, weight: .medium))
                .foregroundColor(.finoraAIAccent)

            VStack(spacing: 8) {
                Text("Camera Access Required")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)

                Text("To scan receipts and QR codes, please allow camera access")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)

            Button(action: {
                Task {
                    await cameraManager.requestPermission()
                }
            }) {
                Text("Allow Camera Access")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            colors: [Color.finoraAIAccent, Color.finoraAIAccent.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
            }
            .padding(.horizontal, 40)

            Spacer()

            // Alternative: Use photo library
            VStack(spacing: 16) {
                Text("Or select from photo library")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))

                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    Text("Choose Photo")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.finoraAIAccent)
                }
            }
            .padding(.bottom, 40)
        }
    }

    // MARK: - Permission Denied View

    private var permissionDeniedView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "camera.fill")
                .font(.system(size: 64, weight: .medium))
                .foregroundColor(.finoraWarning)

            VStack(spacing: 8) {
                Text("Camera Access Denied")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)

                Text("Please enable camera access in Settings to scan receipts")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)

            Button(action: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Open Settings")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.finoraSurface)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 40)

            Spacer()

            // Alternative: Use photo library
            VStack(spacing: 16) {
                Text("Or select from photo library")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white.opacity(0.6))

                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    Text("Choose Photo")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.finoraAIAccent)
                }
            }
            .padding(.bottom, 40)
        }
    }

    // MARK: - Processing Overlay

    private var processingOverlay: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .finoraAIAccent))
                    .scaleEffect(1.5)

                Text("Processing...")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }

    // MARK: - Helper Methods

    private func setupCamera() {
        Task {
            if cameraManager.permissionStatus == .notDetermined {
                await cameraManager.requestPermission()
            }

            if cameraManager.permissionStatus == .authorized {
                do {
                    try cameraManager.setupSession()
                    cameraManager.startSession()
                } catch {
                    print("Camera setup failed: \(error)")
                }
            }
        }
    }

    private func processImage(_ image: UIImage) {
        isProcessing = true

        Task {
            do {
                let extractedData = try await OCRService.shared.extractText(from: image)

                let receipt = ScannedReceipt(
                    image: image,
                    extractedData: extractedData,
                    processingStatus: .completed
                )

                viewModel.processReceipt(receipt)

                await MainActor.run {
                    isProcessing = false
                    showPreview = true
                }
            } catch {
                await MainActor.run {
                    isProcessing = false
                    // Show error or navigate to manual entry
                    viewModel.receiptImage = image
                    showPreview = true
                }
            }
        }
    }

    private func processQRCode(_ qrCode: String) {
        // Show alert with QR code content
        showQRResult = true
    }

    private func parseQRCodeData(_ qrCode: String) {
        // Try to parse QR code data
        // Common formats: URL with transaction data, JSON, plain text amount

        // Check if it's a URL
        if let url = URL(string: qrCode), url.scheme != nil {
            // Could be a payment link or receipt URL
            viewModel.notes = "QR Code: \(qrCode)"
        }

        // Try to extract amount from QR code
        let amountPattern = #"(\d+[.,]\d{2})"#
        if let regex = try? NSRegularExpression(pattern: amountPattern),
           let match = regex.firstMatch(in: qrCode, range: NSRange(qrCode.startIndex..., in: qrCode)),
           let range = Range(match.range(at: 1), in: qrCode) {
            let amountString = String(qrCode[range]).replacingOccurrences(of: ",", with: ".")
            viewModel.amountText = amountString
        }

        // Set a default item name from QR
        viewModel.itemName = "QR Code Transaction"
        viewModel.notes = qrCode

        // Navigate to preview
        showPreview = true
    }

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.6)) {
            headerOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
            controlsOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ReceiptScannerView()
            .environmentObject(AppRouter())
    }
}
