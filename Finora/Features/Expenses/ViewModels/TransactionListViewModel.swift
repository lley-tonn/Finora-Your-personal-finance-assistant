//
//  TransactionListViewModel.swift
//  Finora
//
//  ViewModel for transaction list with filtering, sorting, and grouping
//

import SwiftUI
import Combine

@MainActor
class TransactionListViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var expenses: [Expense] = []
    @Published var selectedFilter: TimeFilter = .all
    @Published var selectedCategory: ExpenseCategory?
    @Published var sortOrder: SortOrder = .dateDescending
    @Published var expenseToEdit: Expense?

    // MARK: - Services

    private let storageService = ExpenseStorageService.shared

    // MARK: - Enums

    enum TimeFilter: String, CaseIterable {
        case all = "All"
        case today = "Today"
        case thisWeek = "This Week"
        case thisMonth = "This Month"
    }

    enum SortOrder {
        case dateDescending
        case dateAscending
        case amountDescending
        case amountAscending
    }

    // MARK: - Computed Properties

    var filteredExpenses: [Expense] {
        var result = expenses

        // Apply time filter
        switch selectedFilter {
        case .all:
            break
        case .today:
            result = result.filter { $0.isToday }
        case .thisWeek:
            result = result.filter { $0.isThisWeek }
        case .thisMonth:
            result = result.filter { $0.isThisMonth }
        }

        // Apply category filter
        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }

        // Apply sorting
        switch sortOrder {
        case .dateDescending:
            result.sort { $0.date > $1.date }
        case .dateAscending:
            result.sort { $0.date < $1.date }
        case .amountDescending:
            result.sort { $0.totalAmount > $1.totalAmount }
        case .amountAscending:
            result.sort { $0.totalAmount < $1.totalAmount }
        }

        return result
    }

    var groupedExpenses: [Date: [Expense]] {
        let calendar = Calendar.current
        var grouped: [Date: [Expense]] = [:]

        for expense in filteredExpenses {
            let dateKey = calendar.startOfDay(for: expense.date)
            if grouped[dateKey] == nil {
                grouped[dateKey] = []
            }
            grouped[dateKey]?.append(expense)
        }

        return grouped
    }

    var totalSpent: Decimal {
        filteredExpenses.reduce(0) { $0 + $1.totalAmount }
    }

    var totalSpentFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: totalSpent as NSNumber) ?? "$0.00"
    }

    // MARK: - Methods

    func loadExpenses() {
        expenses = storageService.loadExpenses()
    }

    func deleteExpense(_ expense: Expense) {
        storageService.deleteExpense(id: expense.id)
        loadExpenses()
    }

    func updateExpense(_ expense: Expense) {
        storageService.updateExpense(expense)
        loadExpenses()
    }

    func formatSectionDate(_ date: Date) -> String {
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d"
            return formatter.string(from: date)
        }
    }

    func totalForDate(_ date: Date) -> String {
        let total = groupedExpenses[date]?.reduce(0) { $0 + $1.totalAmount } ?? 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: total as NSNumber) ?? "$0.00"
    }
}
