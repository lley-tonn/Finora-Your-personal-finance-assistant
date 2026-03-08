//
//  ExpenseViewModel.swift
//  Finora
//
//  ViewModel for expense entry forms
//  Handles form state, validation, and saving expenses
//

import SwiftUI
import Combine

@MainActor
class ExpenseViewModel: ObservableObject {

    // MARK: - Form State

    @Published var itemName: String = ""
    @Published var amountText: String = ""
    @Published var selectedCategory: ExpenseCategory = .other
    @Published var quantity: Int = 1
    @Published var notes: String = ""
    @Published var selectedDate: Date = Date()

    // MARK: - UI State

    @Published var isLoading: Bool = false
    @Published var showConfirmation: Bool = false
    @Published var errorMessage: String?
    @Published var savedExpense: Expense?

    // MARK: - Receipt State

    @Published var scannedReceipt: ScannedReceipt?
    @Published var receiptImage: UIImage?

    // MARK: - Services

    private let storageService = ExpenseStorageService.shared

    // MARK: - Computed Properties

    var amount: Decimal {
        Decimal(string: amountText.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    var isQuickExpenseValid: Bool {
        amount > 0
    }

    var isDetailedExpenseValid: Bool {
        !itemName.trimmingCharacters(in: .whitespaces).isEmpty && amount > 0
    }

    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: (amount * Decimal(quantity)) as NSNumber) ?? "$0.00"
    }

    // MARK: - Quick Expense Methods

    /// Save a quick expense (amount + category only)
    func saveQuickExpense() {
        guard isQuickExpenseValid else {
            errorMessage = "Please enter a valid amount"
            return
        }

        isLoading = true

        let expense = Expense(
            itemName: selectedCategory.rawValue,
            amount: amount,
            category: selectedCategory,
            quantity: 1,
            notes: "",
            date: Date()
        )

        storageService.addExpense(expense)
        savedExpense = expense
        showConfirmation = true
        isLoading = false

        // Reset form
        resetForm()
    }

    /// Save a detailed expense with all fields
    func saveDetailedExpense() {
        guard isDetailedExpenseValid else {
            errorMessage = "Please fill in required fields"
            return
        }

        isLoading = true

        let expense = Expense(
            itemName: itemName.trimmingCharacters(in: .whitespaces),
            amount: amount,
            category: selectedCategory,
            quantity: quantity,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines),
            date: selectedDate,
            receiptImagePath: nil  // TODO: Save receipt image if available
        )

        storageService.addExpense(expense)
        savedExpense = expense
        showConfirmation = true
        isLoading = false

        // Reset form
        resetForm()
    }

    // MARK: - Receipt Methods

    /// Process a scanned receipt and populate form fields
    func processReceipt(_ receipt: ScannedReceipt) {
        scannedReceipt = receipt
        receiptImage = receipt.image

        if let data = receipt.extractedData {
            // Populate form from extracted data
            if let merchant = data.merchantName {
                itemName = merchant
            }

            if let total = data.totalAmount {
                amountText = "\(total)"
            }

            if let receiptDate = data.date {
                selectedDate = receiptDate
            }

            selectedCategory = data.suggestedCategory
        }
    }

    /// Save expense from scanned receipt
    func saveReceiptExpense() {
        guard isDetailedExpenseValid else {
            errorMessage = "Please verify the expense details"
            return
        }

        saveDetailedExpense()
    }

    // MARK: - Helper Methods

    /// Reset form to initial state
    func resetForm() {
        itemName = ""
        amountText = ""
        selectedCategory = .other
        quantity = 1
        notes = ""
        selectedDate = Date()
        errorMessage = nil
        scannedReceipt = nil
        receiptImage = nil
    }

    /// Increment quantity
    func incrementQuantity() {
        if quantity < 99 {
            quantity += 1
        }
    }

    /// Decrement quantity
    func decrementQuantity() {
        if quantity > 1 {
            quantity -= 1
        }
    }

    /// Dismiss confirmation
    func dismissConfirmation() {
        showConfirmation = false
        savedExpense = nil
    }

    /// Clear error message
    func clearError() {
        errorMessage = nil
    }
}
