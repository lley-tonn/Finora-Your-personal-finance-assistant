//
//  RiskProfileView.swift
//  Finora
//

import SwiftUI

struct RiskProfileView: View {
    @State private var riskTolerance = 0.5

    var body: some View {
        VStack(spacing: 30) {
            Text("What's your risk tolerance?")
                .font(.title2.bold())

            Slider(value: $riskTolerance, in: 0...1)
            Text(riskTolerance < 0.33 ? "Conservative" : riskTolerance < 0.67 ? "Moderate" : "Aggressive")

            Button("Save Profile") {}
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Risk Profile")
    }
}
