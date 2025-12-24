//
//  DashboardViewModel.swift
//  Finora
//
//  Manages dashboard data and AI insights
//

import Foundation

@MainActor
class DashboardViewModel: ObservableObject {

    @Published var totalBalance: Double = 0
    @Published var insights: [AIInsight] = []
    @Published var recentTransactions: [Transaction] = []

    func loadDashboardData() async {
        // TODO: Load from storage/blockchain
    }

    func refreshInsights() async {
        // TODO: Fetch AI insights
    }
}

struct AIInsight {
    let id: String
    let message: String
    let type: InsightType

    enum InsightType {
        case savings, spending, investment, debt
    }
}

struct Transaction {
    let id: String
    let description: String
    let amount: Double
    let category: String
    let date: Date
}
