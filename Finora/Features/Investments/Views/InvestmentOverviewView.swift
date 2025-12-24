//
//  InvestmentOverviewView.swift
//  Finora
//

import SwiftUI

struct InvestmentOverviewView: View {
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Portfolio Value: $12,450")
                    .font(.title.bold())

                Text("+15.3% YTD")
                    .foregroundColor(.finoraSuccess)

                Button("Assess Risk Profile") {
                    router.navigate(to: .riskProfile)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Investments")
    }
}
