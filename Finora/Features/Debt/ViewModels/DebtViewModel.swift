//
//  DebtViewModel.swift
//  Finora
//

import Foundation

@MainActor
class DebtViewModel: ObservableObject {
    @Published var totalDebt: Double = 0
    @Published var recommendedStrategy: String = "Avalanche"

    func optimizePayoff() async {
        // TODO: Use AI to calculate optimal strategy
    }
}
