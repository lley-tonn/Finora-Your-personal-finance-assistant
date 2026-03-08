//
//  BudgetViewModel.swift
//  Finora
//
//  Manages budget data, calculations, and expense integration
//

import Foundation
import SwiftUI
import Combine

@MainActor
class BudgetViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var monthlyIncome: Double = 5000
    @Published var budgetCategories: [BudgetCategory] = []
    @Published var isLoading: Bool = false

    // MARK: - Services

    private let expenseStorage = ExpenseStorageService.shared
    private let budgetStorage = BudgetStorageService.shared

    // MARK: - Subscriptions

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Computed Properties

    var totalAllocated: Double {
        budgetCategories.reduce(0) { $0 + $1.allocated }
    }

    var totalSpent: Double {
        budgetCategories.reduce(0) { $0 + $1.spent }
    }

    var remainingBudget: Double {
        totalAllocated - totalSpent
    }

    var overallPercentage: Double {
        totalAllocated > 0 ? min(totalSpent / totalAllocated, 1.0) : 0
    }

    var isOverBudget: Bool {
        totalSpent > totalAllocated
    }

    var formattedTotalSpent: String {
        formatCurrency(totalSpent)
    }

    var formattedTotalAllocated: String {
        formatCurrency(totalAllocated)
    }

    var formattedRemaining: String {
        formatCurrency(remainingBudget)
    }

    // MARK: - Initialization

    init() {
        loadBudget()
        observeExpenseChanges()
    }

    private func observeExpenseChanges() {
        NotificationCenter.default.publisher(for: .expensesDidChange)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.refreshSpending()
            }
            .store(in: &cancellables)
    }

    // MARK: - Methods

    func loadBudget() {
        isLoading = true

        // Load saved budget allocations
        let savedAllocations = budgetStorage.loadAllocations()

        // Get spending by category from expenses
        let spendingByCategory = expenseStorage.getCurrentMonthSpendingByCategory()

        // Build budget categories with actual spending
        budgetCategories = buildBudgetCategories(
            allocations: savedAllocations,
            spending: spendingByCategory
        )

        isLoading = false
    }

    func updateAllocation(for categoryName: String, amount: Double) {
        if let index = budgetCategories.firstIndex(where: { $0.name == categoryName }) {
            budgetCategories[index].allocated = amount
            saveBudget()
        }
    }

    func saveBudget() {
        let allocations = budgetCategories.map { category in
            BudgetAllocation(categoryName: category.name, allocated: category.allocated)
        }
        budgetStorage.saveAllocations(allocations)
    }

    func refreshSpending() {
        let spendingByCategory = expenseStorage.getCurrentMonthSpendingByCategory()

        for index in budgetCategories.indices {
            let categoryName = budgetCategories[index].name

            // Find matching ExpenseCategory
            if let expenseCategory = ExpenseCategory.allCases.first(where: {
                $0.toBudgetCategoryName() == categoryName || $0.rawValue == categoryName
            }) {
                let spent = spendingByCategory[expenseCategory] ?? 0
                budgetCategories[index].spent = NSDecimalNumber(decimal: spent).doubleValue
            }
        }
    }

    // MARK: - Private Methods

    private func buildBudgetCategories(
        allocations: [BudgetAllocation],
        spending: [ExpenseCategory: Decimal]
    ) -> [BudgetCategory] {
        // Default categories with suggested allocations
        let defaultCategories: [(name: String, icon: String, color: String, defaultAllocation: Double)] = [
            ("Groceries", "cart.fill", "finoraExpense", 500),
            ("Dining Out", "fork.knife", "finoraWarning", 300),
            ("Transportation", "car.fill", "finoraInfo", 400),
            ("Entertainment", "film.fill", "finoraAIAccent", 200),
            ("Shopping", "bag.fill", "finoraSecurity", 300),
            ("Health", "heart.fill", "finoraSuccess", 200),
            ("Utilities", "bolt.fill", "finoraWarning", 250),
            ("Subscriptions", "repeat", "finoraInfo", 100)
        ]

        return defaultCategories.map { category in
            // Get saved allocation or use default
            let allocation = allocations.first { $0.categoryName == category.name }?.allocated ?? category.defaultAllocation

            // Get spent amount from expenses
            var spent: Double = 0
            if let expenseCategory = ExpenseCategory.allCases.first(where: {
                $0.toBudgetCategoryName() == category.name || $0.rawValue == category.name
            }) {
                spent = NSDecimalNumber(decimal: spending[expenseCategory] ?? 0).doubleValue
            }

            return BudgetCategory(
                name: category.name,
                allocated: allocation,
                spent: spent,
                icon: category.icon,
                color: category.color
            )
        }
    }

    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }
}

// MARK: - Budget Category Model

struct BudgetCategory: Identifiable {
    let id = UUID()
    let name: String
    var allocated: Double
    var spent: Double
    let icon: String
    let color: String

    var percentage: Double {
        allocated > 0 ? min(spent / allocated, 1.0) : 0
    }

    var isOverBudget: Bool {
        spent > allocated
    }

    var remaining: Double {
        max(allocated - spent, 0)
    }

    var formattedAllocated: String {
        formatCurrency(allocated)
    }

    var formattedSpent: String {
        formatCurrency(spent)
    }

    var formattedRemaining: String {
        formatCurrency(remaining)
    }

    var percentageInt: Int {
        Int(percentage * 100)
    }

    var statusColor: Color {
        if percentage >= 1.0 {
            return .finoraExpense
        } else if percentage >= 0.8 {
            return .finoraWarning
        } else {
            return .finoraSuccess
        }
    }

    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }
}

// MARK: - Budget Allocation (for persistence)

struct BudgetAllocation: Codable {
    let categoryName: String
    var allocated: Double
}
