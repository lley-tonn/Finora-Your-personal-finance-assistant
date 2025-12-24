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

struct BudgetCategory {
    let name: String
    var allocated: Double
    var spent: Double
}
