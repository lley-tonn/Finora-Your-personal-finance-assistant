//
//  EditExpenseView.swift
//  Finora
//
//  Edit an existing expense with option to delete
//

import SwiftUI

struct EditExpenseView: View {

    // MARK: - Properties

    @Environment(\.dismiss) private var dismiss

    let expense: Expense
    let onSave: (Expense) -> Void
    let onDelete: () -> Void

    // Form State
    @State private var itemName: String
    @State private var amountText: String
    @State private var selectedCategory: ExpenseCategory
    @State private var quantity: Int
    @State private var notes: String
    @State private var selectedDate: Date

    // UI State
    @State private var showDeleteConfirmation = false

    // Animation States
    @State private var headerOpacity: Double = 0
    @State private var fieldsOpacity: Double = 0
    @State private var fieldsOffset: CGFloat = 20
    @State private var buttonOpacity: Double = 0

    // MARK: - Initialization

    init(expense: Expense, onSave: @escaping (Expense) -> Void, onDelete: @escaping () -> Void) {
        self.expense = expense
        self.onSave = onSave
        self.onDelete = onDelete

        _itemName = State(initialValue: expense.itemName)
        _amountText = State(initialValue: "\(expense.amount)")
        _selectedCategory = State(initialValue: expense.category)
        _quantity = State(initialValue: expense.quantity)
        _notes = State(initialValue: expense.notes)
        _selectedDate = State(initialValue: expense.date)
    }

    // MARK: - Computed Properties

    private var amount: Decimal {
        Decimal(string: amountText.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    private var isFormValid: Bool {
        !itemName.trimmingCharacters(in: .whitespaces).isEmpty && amount > 0
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.finoraBackground.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Header
                        header
                            .opacity(headerOpacity)
                            .padding(.top, 16)

                        // Form Fields
                        formFields
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.finoraTextSecondary)
                }
            }
            .preferredColorScheme(.dark)
            .onAppear {
                animateAppearance()
            }
            .alert("Delete Expense", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    onDelete()
                    dismiss()
                }
            } message: {
                Text("Are you sure you want to delete this expense? This action cannot be undone.")
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(selectedCategory.color.opacity(0.15))
                    .frame(width: 64, height: 64)

                Image(systemName: selectedCategory.icon)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(selectedCategory.color)
            }

            Text("Edit Expense")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.finoraTextPrimary)

            Text("Created \(expense.formattedDate)")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.finoraTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Form Fields

    private var formFields: some View {
        VStack(spacing: 20) {
            // Item Name
            VStack(alignment: .leading, spacing: 8) {
                Text("Item Name")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                TextField("", text: $itemName)
                    .textFieldStyle(FinoraTextFieldStyle())
                    .autocapitalization(.words)
            }

            // Amount
            VStack(alignment: .leading, spacing: 8) {
                Text("Amount")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                HStack(spacing: 0) {
                    Text("$")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)
                        .padding(.leading, 16)

                    TextField("0.00", text: $amountText)
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
            CompactCategoryPickerView(selectedCategory: $selectedCategory)

            // Quantity and Date
            HStack(spacing: 16) {
                // Quantity
                VStack(alignment: .leading, spacing: 8) {
                    Text("Quantity")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)

                    HStack(spacing: 0) {
                        Button(action: {
                            if quantity > 1 { quantity -= 1 }
                        }) {
                            Image(systemName: "minus")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.finoraTextSecondary)
                                .frame(width: 44, height: 52)
                        }

                        Text("\(quantity)")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.finoraTextPrimary)
                            .frame(maxWidth: .infinity)

                        Button(action: {
                            if quantity < 99 { quantity += 1 }
                        }) {
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

                // Date
                VStack(alignment: .leading, spacing: 8) {
                    Text("Date")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)

                    DatePicker(
                        "",
                        selection: $selectedDate,
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

            // Notes
            VStack(alignment: .leading, spacing: 8) {
                Text("Notes (Optional)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                TextEditor(text: $notes)
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
            Button(action: saveExpense) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 15, weight: .semibold))

                    Text("Save Changes")
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
            .disabled(!isFormValid)
            .opacity(isFormValid ? 1.0 : 0.5)

            // Delete Button
            Button(action: {
                showDeleteConfirmation = true
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "trash")
                        .font(.system(size: 15, weight: .medium))

                    Text("Delete Expense")
                        .font(.system(size: 17, weight: .medium))
                }
                .foregroundColor(.finoraExpense)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.finoraExpense.opacity(0.5), lineWidth: 1)
                )
            }
        }
    }

    // MARK: - Actions

    private func saveExpense() {
        var updatedExpense = expense
        updatedExpense.itemName = itemName.trimmingCharacters(in: .whitespaces)
        updatedExpense.amount = amount
        updatedExpense.category = selectedCategory
        updatedExpense.quantity = quantity
        updatedExpense.notes = notes.trimmingCharacters(in: .whitespacesAndNewlines)
        updatedExpense.date = selectedDate
        updatedExpense.updatedAt = Date()

        onSave(updatedExpense)
        dismiss()
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.5)) {
            headerOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
            fieldsOpacity = 1.0
            fieldsOffset = 0
        }

        withAnimation(.easeInOut(duration: 0.4).delay(0.2)) {
            buttonOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    EditExpenseView(
        expense: Expense.samples.first!,
        onSave: { _ in },
        onDelete: { }
    )
}
