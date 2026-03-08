//
//  ExpenseStorageService.swift
//  Finora
//
//  Handles persistence of expenses using UserDefaults
//  MVP implementation - can be migrated to Core Data later
//

import Foundation

// Notification for expense changes
extension Notification.Name {
    static let expensesDidChange = Notification.Name("expensesDidChange")
}

class ExpenseStorageService {

    // MARK: - Singleton

    static let shared = ExpenseStorageService()
    private init() {}

    // MARK: - Constants

    private let storageKey = "finora_expenses"

    // MARK: - CRUD Operations

    /// Load all expenses from storage
    func loadExpenses() -> [Expense] {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            return []
        }

        do {
            let expenses = try JSONDecoder().decode([Expense].self, from: data)
            return expenses.sorted { $0.date > $1.date }
        } catch {
            print("Failed to decode expenses: \(error)")
            return []
        }
    }

    /// Save all expenses to storage
    func saveExpenses(_ expenses: [Expense]) {
        do {
            let data = try JSONEncoder().encode(expenses)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to encode expenses: \(error)")
        }
    }

    /// Add a new expense
    func addExpense(_ expense: Expense) {
        var expenses = loadExpenses()
        expenses.insert(expense, at: 0)
        saveExpenses(expenses)
        notifyExpensesChanged()
    }

    /// Update an existing expense
    func updateExpense(_ expense: Expense) {
        var expenses = loadExpenses()
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            var updatedExpense = expense
            updatedExpense.updatedAt = Date()
            expenses[index] = updatedExpense
            saveExpenses(expenses)
            notifyExpensesChanged()
        }
    }

    /// Delete an expense by ID
    func deleteExpense(id: UUID) {
        var expenses = loadExpenses()
        expenses.removeAll { $0.id == id }
        saveExpenses(expenses)
        notifyExpensesChanged()
    }

    /// Post notification that expenses have changed
    private func notifyExpensesChanged() {
        NotificationCenter.default.post(name: .expensesDidChange, object: nil)
    }

    /// Get expense by ID
    func getExpense(id: UUID) -> Expense? {
        return loadExpenses().first { $0.id == id }
    }

    // MARK: - Query Operations

    /// Get expenses for a specific date range
    func getExpenses(from startDate: Date, to endDate: Date) -> [Expense] {
        return loadExpenses().filter { expense in
            expense.date >= startDate && expense.date <= endDate
        }
    }

    /// Get expenses for current month
    func getCurrentMonthExpenses() -> [Expense] {
        let calendar = Calendar.current
        let now = Date()
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now)),
              let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else {
            return []
        }
        return getExpenses(from: startOfMonth, to: endOfMonth)
    }

    /// Get expenses for current week
    func getCurrentWeekExpenses() -> [Expense] {
        let calendar = Calendar.current
        let now = Date()
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)),
              let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            return []
        }
        return getExpenses(from: startOfWeek, to: endOfWeek)
    }

    /// Get today's expenses
    func getTodayExpenses() -> [Expense] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
            return []
        }
        return getExpenses(from: startOfDay, to: endOfDay)
    }

    /// Get expenses by category
    func getExpenses(for category: ExpenseCategory) -> [Expense] {
        return loadExpenses().filter { $0.category == category }
    }

    // MARK: - Analytics

    /// Get total spending for current month
    func getCurrentMonthTotal() -> Decimal {
        return getCurrentMonthExpenses().reduce(0) { $0 + $1.totalAmount }
    }

    /// Get spending by category for current month
    func getCurrentMonthSpendingByCategory() -> [ExpenseCategory: Decimal] {
        var categoryTotals: [ExpenseCategory: Decimal] = [:]

        for expense in getCurrentMonthExpenses() {
            categoryTotals[expense.category, default: 0] += expense.totalAmount
        }

        return categoryTotals
    }

    /// Clear all expenses (for testing/reset)
    func clearAllExpenses() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}
