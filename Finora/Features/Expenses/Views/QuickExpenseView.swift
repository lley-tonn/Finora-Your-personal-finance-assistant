//
//  QuickExpenseView.swift
//  Finora
//
//  Quick expense entry with minimal fields
//  Amount input + category selection for fast logging
//

import SwiftUI

struct QuickExpenseView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel = ExpenseViewModel()
    @Environment(\.dismiss) private var dismiss

    // Animation States
    @State private var headerOpacity: Double = 0
    @State private var amountOpacity: Double = 0
    @State private var amountOffset: CGFloat = 20
    @State private var categoryOpacity: Double = 0
    @State private var buttonOpacity: Double = 0

    @FocusState private var isAmountFocused: Bool

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.finoraBackground.ignoresSafeArea()

            VStack(spacing: 32) {
                // Header
                header
                    .opacity(headerOpacity)

                // Amount Input
                amountSection
                    .opacity(amountOpacity)
                    .offset(y: amountOffset)

                // Category Picker
                categorySection
                    .opacity(categoryOpacity)

                Spacer()

                // Save Button
                saveButton
                    .opacity(buttonOpacity)
                    .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
        .navigationBarBackButtonHidden()
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)
                }
            }
        }
        .onAppear {
            animateAppearance()
            isAmountFocused = true
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") { viewModel.clearError() }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .onChange(of: viewModel.showConfirmation) { showConfirmation in
            if showConfirmation {
                dismiss()
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 8) {
            Image(systemName: "bolt.fill")
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.finoraAIAccent)

            Text("Quick Expense")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.finoraTextPrimary)

            Text("Enter amount and select category")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.finoraTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Amount Section

    private var amountSection: some View {
        VStack(spacing: 8) {
            Text("Amount")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraTextSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 4) {
                Text("$")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.finoraTextSecondary)

                TextField("0", text: $viewModel.amountText)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.finoraTextPrimary)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.leading)
                    .focused($isAmountFocused)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
        }
    }

    // MARK: - Category Section

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Category")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraTextSecondary)

            CategoryPickerView(selectedCategory: $viewModel.selectedCategory, columns: 4)
        }
    }

    // MARK: - Save Button

    private var saveButton: some View {
        Button(action: {
            viewModel.saveQuickExpense()
        }) {
            HStack(spacing: 8) {
                Text("Save Expense")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)

                Image(systemName: "checkmark")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
            }
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
            .shadow(color: Color.finoraAIAccent.opacity(0.3), radius: 16, x: 0, y: 8)
        }
        .disabled(!viewModel.isQuickExpenseValid)
        .opacity(viewModel.isQuickExpenseValid ? 1.0 : 0.5)
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.6)) {
            headerOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.1)) {
            amountOpacity = 1.0
            amountOffset = 0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
            categoryOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            buttonOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        QuickExpenseView()
            .environmentObject(AppRouter())
    }
}
