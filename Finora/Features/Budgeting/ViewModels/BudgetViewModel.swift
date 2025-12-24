//
//  BudgetViewModel.swift
//  Finora - Manages budget data and calculations
//

import Foundation

@MainActor
class BudgetViewModel: ObservableObject {
    @Published var monthlyIncome: Double = 0
    @Published var budgetCategories: [BudgetCategory] = []

    func saveBudget() async {
        // TODO: Save to encrypted storage
    }
}

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
}
