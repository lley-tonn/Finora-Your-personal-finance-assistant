//
//  BudgetStorageService.swift
//  Finora
//
//  Handles persistence of budget allocations using UserDefaults
//  Works alongside ExpenseStorageService for complete budget tracking
//

import Foundation

class BudgetStorageService {

    // MARK: - Singleton

    static let shared = BudgetStorageService()
    private init() {}

    // MARK: - Constants

    private let allocationsKey = "finora_budget_allocations"
    private let incomeKey = "finora_monthly_income"

    // MARK: - Allocation Methods

    /// Load all budget allocations
    func loadAllocations() -> [BudgetAllocation] {
        guard let data = UserDefaults.standard.data(forKey: allocationsKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode([BudgetAllocation].self, from: data)
        } catch {
            print("Failed to decode budget allocations: \(error)")
            return []
        }
    }

    /// Save all budget allocations
    func saveAllocations(_ allocations: [BudgetAllocation]) {
        do {
            let data = try JSONEncoder().encode(allocations)
            UserDefaults.standard.set(data, forKey: allocationsKey)
        } catch {
            print("Failed to encode budget allocations: \(error)")
        }
    }

    /// Update a single allocation
    func updateAllocation(categoryName: String, amount: Double) {
        var allocations = loadAllocations()

        if let index = allocations.firstIndex(where: { $0.categoryName == categoryName }) {
            allocations[index].allocated = amount
        } else {
            allocations.append(BudgetAllocation(categoryName: categoryName, allocated: amount))
        }

        saveAllocations(allocations)
    }

    /// Get allocation for a specific category
    func getAllocation(for categoryName: String) -> Double? {
        return loadAllocations().first { $0.categoryName == categoryName }?.allocated
    }

    // MARK: - Income Methods

    /// Load monthly income
    func loadMonthlyIncome() -> Double {
        return UserDefaults.standard.double(forKey: incomeKey)
    }

    /// Save monthly income
    func saveMonthlyIncome(_ income: Double) {
        UserDefaults.standard.set(income, forKey: incomeKey)
    }

    // MARK: - Reset

    /// Clear all budget data
    func clearAllBudgetData() {
        UserDefaults.standard.removeObject(forKey: allocationsKey)
        UserDefaults.standard.removeObject(forKey: incomeKey)
    }
}
