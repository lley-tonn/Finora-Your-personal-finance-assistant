//
//  InvestmentViewModel.swift
//  Finora
//

import Foundation

@MainActor
class InvestmentViewModel: ObservableObject {
    @Published var portfolioValue: Double = 0
    @Published var riskProfile: String = "Moderate"

    func assessRisk(answers: [String: Any]) async {
        // TODO: Use AI to assess risk
    }
}
