//
//  DebtStrategyView.swift
//  Finora
//

import SwiftUI

struct DebtStrategyView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Recommended Strategy: Avalanche Method")
                .font(.headline)

            Text("Pay off high-interest debts first to save $1,200 in interest")
                .multilineTextAlignment(.center)

            Button("Apply Strategy") {}
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Debt Strategy")
    }
}
