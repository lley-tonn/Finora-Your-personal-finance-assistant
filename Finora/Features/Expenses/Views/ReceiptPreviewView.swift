//
//  ReceiptPreviewView.swift
//  Finora
//
//  Preview and edit OCR results from scanned receipt
//  Allows manual correction before saving expense
//

import SwiftUI

struct ReceiptPreviewView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject var viewModel: ExpenseViewModel
    @Environment(\.dismiss) private var dismiss

    // Animation States
    @State private var imageOpacity: Double = 0
    @State private var imageScale: CGFloat = 0.9
    @State private var fieldsOpacity: Double = 0
    @State private var fieldsOffset: CGFloat = 20
    @State private var buttonOpacity: Double = 0

    // Image Preview
    @State private var showFullImage = false

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.finoraBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Receipt Image Preview
                    receiptImagePreview
                        .opacity(imageOpacity)
                        .scaleEffect(imageScale)
                        .padding(.top, 16)

                    // Confidence Indicator
                    if let receipt = viewModel.scannedReceipt,
                       let data = receipt.extractedData {
                        confidenceIndicator(data)
                            .opacity(fieldsOpacity)
                    }

                    // Extracted Fields
                    extractedFields
                        .opacity(fieldsOpacity)
                        .offset(y: fieldsOffset)

                    // Action Buttons
                    actionButtons
                        .opacity(buttonOpacity)
                        .padding(.top, 8)
                        .padding(.bottom, 32)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Review Receipt")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)
                }
            }
        }
        .onAppear {
            animateAppearance()
        }
        .sheet(isPresented: $showFullImage) {
            fullImageView
        }
        .onChange(of: viewModel.showConfirmation) { showConfirmation in
            if showConfirmation {
                dismiss()
            }
        }
    }

    // MARK: - Receipt Image Preview

    private var receiptImagePreview: some View {
        Button(action: { showFullImage = true }) {
            ZStack {
                if let image = viewModel.receiptImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(16)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.finoraSurface)
                        .frame(height: 200)
                        .overlay(
                            VStack(spacing: 8) {
                                Image(systemName: "doc.text.viewfinder")
                                    .font(.system(size: 32))
                                    .foregroundColor(.finoraTextTertiary)

                                Text("No image available")
                                    .font(.system(size: 14))
                                    .foregroundColor(.finoraTextTertiary)
                            }
                        )
                }

                // Tap to expand indicator
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(8)
                            .padding(12)
                    }
                }
            }
        }
    }

    // MARK: - Confidence Indicator

    private func confidenceIndicator(_ data: ExtractedReceiptData) -> some View {
        HStack(spacing: 8) {
            Image(systemName: data.isHighConfidence ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(data.isHighConfidence ? .finoraSuccess : .finoraWarning)

            Text(data.isHighConfidence ? "High confidence extraction" : "Please verify details")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(data.isHighConfidence ? .finoraSuccess : .finoraWarning)

            Spacer()

            Text("\(data.confidencePercentage)%")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.finoraTextSecondary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(data.isHighConfidence ? Color.finoraSuccess.opacity(0.1) : Color.finoraWarning.opacity(0.1))
        )
    }

    // MARK: - Extracted Fields

    private var extractedFields: some View {
        VStack(spacing: 20) {
            // Merchant Name
            VStack(alignment: .leading, spacing: 8) {
                Text("Merchant Name")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                TextField("", text: $viewModel.itemName)
                    .textFieldStyle(FinoraTextFieldStyle())
                    .autocapitalization(.words)
            }

            // Amount
            VStack(alignment: .leading, spacing: 8) {
                Text("Total Amount")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                HStack(spacing: 0) {
                    Text("$")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)
                        .padding(.leading, 16)

                    TextField("0.00", text: $viewModel.amountText)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.finoraTextPrimary)
                        .keyboardType(.decimalPad)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 16)
                }
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.finoraSurface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.finoraBorder.opacity(0.3), lineWidth: 1)
                )
            }

            // Category
            CompactCategoryPickerView(selectedCategory: $viewModel.selectedCategory)

            // Date
            VStack(alignment: .leading, spacing: 8) {
                Text("Date")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                DatePicker(
                    "",
                    selection: $viewModel.selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.finoraSurface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.finoraBorder.opacity(0.3), lineWidth: 1)
                )
            }

            // Notes
            VStack(alignment: .leading, spacing: 8) {
                Text("Notes (Optional)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                TextEditor(text: $viewModel.notes)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.finoraTextPrimary)
                    .scrollContentBackground(.hidden)
                    .frame(height: 80)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.finoraSurface)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.finoraBorder.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        VStack(spacing: 12) {
            // Save Button
            Button(action: {
                viewModel.saveReceiptExpense()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 15, weight: .semibold))

                    Text("Save Expense")
                        .font(.system(size: 17, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    LinearGradient(
                        colors: [Color.finoraSuccess, Color.finoraSuccess.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
                .shadow(color: Color.finoraSuccess.opacity(0.3), radius: 16, x: 0, y: 8)
            }
            .disabled(!viewModel.isDetailedExpenseValid)
            .opacity(viewModel.isDetailedExpenseValid ? 1.0 : 0.5)

            // Scan Again Button
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "camera")
                        .font(.system(size: 15, weight: .medium))

                    Text("Scan Again")
                        .font(.system(size: 17, weight: .medium))
                }
                .foregroundColor(.finoraTextSecondary)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.finoraBorder.opacity(0.3), lineWidth: 1)
                )
            }
        }
    }

    // MARK: - Full Image View

    private var fullImageView: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                if let image = viewModel.receiptImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        showFullImage = false
                    }
                    .foregroundColor(.finoraAIAccent)
                }
            }
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeOut(duration: 0.5)) {
            imageOpacity = 1.0
            imageScale = 1.0
        }

        withAnimation(.easeOut(duration: 0.5).delay(0.2)) {
            fieldsOpacity = 1.0
            fieldsOffset = 0
        }

        withAnimation(.easeOut(duration: 0.4).delay(0.4)) {
            buttonOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ReceiptPreviewView(viewModel: ExpenseViewModel())
            .environmentObject(AppRouter())
    }
}
