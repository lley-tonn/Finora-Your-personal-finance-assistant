//
//  AIInsightsViewModel.swift
//  Finora
//

import Foundation

@MainActor
class AIInsightsViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var insights: [String] = []

    func sendMessage(_ text: String) async {
        // TODO: Send to AI engine
    }

    func loadInsights() async {
        // TODO: Fetch AI insights
    }
}

struct ChatMessage {
    let id: String
    let text: String
    let isUser: Bool
    let timestamp: Date
}
