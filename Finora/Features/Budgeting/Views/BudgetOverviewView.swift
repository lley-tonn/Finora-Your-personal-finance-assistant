//
//  BudgetOverviewView.swift
//  Finora - Budget overview and tracking
//

import SwiftUI

struct BudgetOverviewView: View {

    @EnvironmentObject private var router: AppRouter

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Monthly Budget: $3,500 / $4,000")
                    .font(.title2.bold())

                ProgressView(value: 0.875)
                    .tint(.finoraSuccess)

                Button("Edit Budget") {
                    router.navigate(to: .budgetEdit)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Budget")
    }
}
