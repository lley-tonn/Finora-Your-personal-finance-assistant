//
//  DetailedExpenseView.swift
//  Finora
//
//  Full expense entry form with all fields
//  Item name, amount, category, quantity, date, notes
//

import SwiftUI

struct DetailedExpenseView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel = ExpenseViewModel()
    @Environment(\.dismiss) private var dismiss

    // Animation States
    @State private var headerOpacity: Double = 0
    @State private var nameOpacity: Double = 0
    @State private var nameOffset: CGFloat = 20
    @State private var amountOpacity: Double = 0
    @State private var amountOffset: CGFloat = 20
    @State private var categoryOpacity: Double = 0
    @State private var categoryOffset: CGFloat = 20
    @State private var detailsOpacity: Double = 0
    @State private var detailsOffset: CGFloat = 20
    @State private var buttonOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.finoraBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    header
                        .opacity(headerOpacity)
                        .padding(.top, 16)

                    // Item Name Field
                    itemNameField
                        .opacity(nameOpacity)
                        .offset(y: nameOffset)

                    // Amount Field
                    amountField
                        .opacity(amountOpacity)
                        .offset(y: amountOffset)

                    // Category Picker
                    CompactCategoryPickerView(selectedCategory: $viewModel.selectedCategory)
                        .opacity(categoryOpacity)
                        .offset(y: categoryOffset)

                    // Quantity and Date
                    HStack(spacing: 16) {
                        quantityField
                        dateField
                    }
                    .opacity(detailsOpacity)
                    .offset(y: detailsOffset)

                    // Notes Field
                    notesField
                        .opacity(detailsOpacity)
                        .offset(y: detailsOffset)

                    // Save Button
                    saveButton
                        .opacity(buttonOpacity)
                        .padding(.top, 8)
                        .padding(.bottom, 32)
                }
                .padding(.horizontal, 24)
            }
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
            Image(systemName: "list.bullet.clipboard.fill")
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(.finoraSuccess)

            Text("Detailed Entry")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.finoraTextPrimary)

            Text("Add complete expense details")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.finoraTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Item Name Field

    private var itemNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Item Name")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraTextSecondary)

            TextField("", text: $viewModel.itemName)
                .textFieldStyle(FinoraTextFieldStyle())
                .autocapitalization(.words)
        }
    }

    // MARK: - Amount Field

    private var amountField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Amount")
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
    }

    // MARK: - Quantity Field

    private var quantityField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Quantity")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraTextSecondary)

            HStack(spacing: 0) {
                Button(action: { viewModel.decrementQuantity() }) {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)
                        .frame(width: 44, height: 52)
                }

                Text("\(viewModel.quantity)")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)
                    .frame(maxWidth: .infinity)

                Button(action: { viewModel.incrementQuantity() }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.finoraAIAccent)
                        .frame(width: 44, height: 52)
                }
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
    }

    // MARK: - Date Field

    private var dateField: some View {
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
    }

    // MARK: - Notes Field

    private var notesField: some View {
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

    // MARK: - Save Button

    private var saveButton: some View {
        Button(action: {
            viewModel.saveDetailedExpense()
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
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.6)) {
            headerOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.1)) {
            nameOpacity = 1.0
            nameOffset = 0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.15)) {
            amountOpacity = 1.0
            amountOffset = 0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
            categoryOpacity = 1.0
            categoryOffset = 0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.25)) {
            detailsOpacity = 1.0
            detailsOffset = 0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            buttonOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DetailedExpenseView()
            .environmentObject(AppRouter())
    }
}
