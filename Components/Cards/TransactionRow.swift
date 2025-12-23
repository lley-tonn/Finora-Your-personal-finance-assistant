//
//  TransactionRow.swift
//  Finora
//
//  Transaction list row component
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 16) {
            // Category Icon
            Image(systemName: transaction.category.icon)
                .font(.title2)
                .foregroundColor(Color.actionPrimaryText)
                .frame(width: 50, height: 50)
                .background(
                    LinearGradient(
                        colors: [
                            Color.brandGold.opacity(0.8),
                            Color.brandEmerald.opacity(0.6)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(12)
            
            // Transaction Details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.headline)
                    .foregroundColor(Color.textPrimary)
                
                Text(transaction.category.displayName)
                    .font(.caption)
                    .foregroundColor(Color.textSecondary)
                
                Text(transaction.date, style: .date)
                    .font(.caption2)
                    .foregroundColor(Color.textTertiary)
            }
            
            Spacer()
            
            // Amount
            Text(transaction.formattedAmount)
                .font(.headline)
                .foregroundColor(
                    transaction.type == .income 
                        ? Color.transactionIncome 
                        : Color.transactionExpense
                )
        }
        .padding()
        .background(Color.backgroundCard)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.borderSubtle, lineWidth: 1)
        )
        .shadow(color: Color.shadowCard, radius: 4, x: 0, y: 1)
    }
}

