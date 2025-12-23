//
//  BalanceCard.swift
//  Finora
//
//  Balance display card component
//

import SwiftUI

struct BalanceCard: View {
    let balance: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Total Balance")
                .font(.subheadline)
                .foregroundColor(Color.textSecondary)
            
            Text(formatBalance(balance))
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(balance >= 0 ? Color.textPrimary : Color.transactionExpense)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color.backgroundCard)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.brandGold.opacity(0.2),
                            Color.brandEmerald.opacity(0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .cornerRadius(16)
        .shadow(color: Color.shadowCard, radius: 8, x: 0, y: 2)
    }
    
    private func formatBalance(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
}

