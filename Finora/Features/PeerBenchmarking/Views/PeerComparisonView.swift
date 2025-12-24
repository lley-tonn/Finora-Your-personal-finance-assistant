//
//  PeerComparisonView.swift
//  Finora
//

import SwiftUI

struct PeerComparisonView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Anonymous Benchmarking")
                    .font(.title2.bold())

                VStack(alignment: .leading, spacing: 12) {
                    ComparisonRow(metric: "Savings Rate", you: "15%", peers: "12%")
                    ComparisonRow(metric: "Monthly Spending", you: "$3,200", peers: "$3,500")
                    ComparisonRow(metric: "Debt-to-Income", you: "25%", peers: "30%")
                }
            }
            .padding()
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Peer Comparison")
    }
}

struct ComparisonRow: View {
    let metric: String
    let you: String
    let peers: String

    var body: some View {
        HStack {
            Text(metric)
            Spacer()
            VStack(alignment: .trailing) {
                Text("You: \(you)")
                Text("Peers: \(peers)").foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.finoraSurface)
        .cornerRadius(8)
    }
}
