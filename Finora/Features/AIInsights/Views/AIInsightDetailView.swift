//
//  AIInsightDetailView.swift
//  Finora
//

import SwiftUI

struct AIInsightDetailView: View {
    let insight: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(insight)
                    .font(.title2.bold())

                Text("Based on your spending patterns, you could save an additional $150 this month by:")
                    .foregroundColor(.secondary)

                VStack(alignment: .leading, spacing: 12) {
                    Text("• Reducing dining out by 20%")
                    Text("• Switching to a cheaper gym membership")
                    Text("• Canceling unused subscriptions")
                }

                Button("Apply Suggestions") {}
                    .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("AI Insight")
    }
}
