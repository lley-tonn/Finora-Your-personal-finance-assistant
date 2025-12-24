//
//  DebtOverviewView.swift
//  Finora
//

import SwiftUI

struct DebtOverviewView: View {
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Total Debt: $8,500")
                    .font(.title.bold())

                VStack(alignment: .leading) {
                    Text("Credit Card: $3,500")
                    Text("Student Loan: $5,000")
                }

                Button("Optimize Payoff Strategy") {
                    router.navigate(to: .debtStrategy)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Debt")
    }
}
