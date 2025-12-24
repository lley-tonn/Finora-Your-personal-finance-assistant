//
//  ColorSystemExamples.swift
//  Finora
//
//  Comprehensive examples demonstrating the Finora color system
//  Use these as references for building consistent UI components
//

import SwiftUI

// MARK: - Example: Main App Structure

struct FinoraAppExample: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Balance Card
                    BalanceCardExample()

                    // AI Insight Card
                    AIInsightCardExample()

                    // Transaction List
                    TransactionListExample()

                    // Action Buttons
                    ActionButtonsExample()

                    // Status Indicators
                    StatusIndicatorsExample()
                }
                .padding()
            }
            .background(Color.finoraBackground.ignoresSafeArea())
            .navigationTitle("Finora")
        }
    }
}

// MARK: - Example: Balance Card

struct BalanceCardExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text("Total Balance")
                    .font(.subheadline)
                    .foregroundColor(.finoraTextSecondary)

                Spacer()

                Image(systemName: "eye.fill")
                    .foregroundColor(.finoraTextTertiary)
                    .font(.caption)
            }

            // Balance Amount
            Text("$24,567.89")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.finoraTextPrimary)

            // Growth Indicator
            HStack(spacing: 6) {
                Image(systemName: "arrow.up.right")
                    .font(.caption.weight(.semibold))
                Text("+12.5%")
                    .font(.subheadline.weight(.semibold))
                Text("this month")
                    .font(.subheadline)
                    .foregroundColor(.finoraTextSecondary)
            }
            .foregroundColor(.finoraSuccess)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.finoraSurface)
        .cornerRadius(16)
        .finoraCardShadow()
    }
}

// MARK: - Example: AI Insight Card

struct AIInsightCardExample: View {
    var body: some View {
        HStack(spacing: 16) {
            // AI Icon with Gradient
            ZStack {
                Circle()
                    .fill(LinearGradient.finoraAIGradient)
                    .frame(width: 48, height: 48)

                Image(systemName: "sparkles")
                    .foregroundColor(.white)
                    .font(.title3.weight(.semibold))
            }

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text("AI Insight")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.finoraAIAccent)

                Text("You're on track to save $1,200 this month")
                    .font(.subheadline)
                    .foregroundColor(.finoraTextPrimary)

                Text("Keep it up! You're 15% ahead of your goal.")
                    .font(.caption)
                    .foregroundColor(.finoraTextSecondary)
            }

            Spacer()
        }
        .padding(16)
        .background(Color.finoraAIInsightBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.finoraAIAccent.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Example: Transaction List

struct TransactionListExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Transactions")
                .font(.headline)
                .foregroundColor(.finoraTextPrimary)

            VStack(spacing: 1) {
                TransactionRow(
                    icon: "cart.fill",
                    title: "Whole Foods",
                    category: "Groceries",
                    amount: -87.50,
                    color: .finoraExpense
                )

                Divider()
                    .background(Color.finoraDividerSubtle)

                TransactionRow(
                    icon: "dollarsign.circle.fill",
                    title: "Salary Deposit",
                    category: "Income",
                    amount: 5200.00,
                    color: .finoraIncome
                )

                Divider()
                    .background(Color.finoraDividerSubtle)

                TransactionRow(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Investment Return",
                    category: "Investments",
                    amount: 342.18,
                    color: .finoraInvestment
                )
            }
            .background(Color.finoraSurface)
            .cornerRadius(12)
        }
    }
}

struct TransactionRow: View {
    let icon: String
    let title: String
    let category: String
    let amount: Double
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.12))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 16, weight: .semibold))
            }

            // Title & Category
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.finoraTextPrimary)

                Text(category)
                    .font(.caption)
                    .foregroundColor(.finoraTextSecondary)
            }

            Spacer()

            // Amount
            Text(formatAmount(amount))
                .font(.subheadline.weight(.semibold))
                .foregroundColor(amount >= 0 ? .finoraSuccess : .finoraTextPrimary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private func formatAmount(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return (amount >= 0 ? "+" : "") + (formatter.string(from: NSNumber(value: amount)) ?? "$0.00")
    }
}

// MARK: - Example: Action Buttons

struct ActionButtonsExample: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Button Examples")
                .font(.headline)
                .foregroundColor(.finoraTextPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Primary Button
            Button(action: {}) {
                Text("Primary Action")
                    .font(.headline)
                    .foregroundColor(.finoraTextOnPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.finoraButtonPrimary)
                    .cornerRadius(12)
            }

            // AI Action Button with Gradient
            Button(action: {}) {
                HStack {
                    Image(systemName: "sparkles")
                    Text("Get AI Insights")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(LinearGradient.finoraAIGradient)
                .cornerRadius(12)
            }

            // Secondary Button
            Button(action: {}) {
                Text("Secondary Action")
                    .font(.headline)
                    .foregroundColor(.finoraTextPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.finoraButtonSecondary)
                    .cornerRadius(12)
            }

            // Outline Button
            Button(action: {}) {
                Text("Outline Action")
                    .font(.headline)
                    .foregroundColor(.finoraLink)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.finoraBorder, lineWidth: 2)
                    )
            }
        }
    }
}

// MARK: - Example: Status Indicators

struct StatusIndicatorsExample: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Status Indicators")
                .font(.headline)
                .foregroundColor(.finoraTextPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Success State
            StatusBadge(
                icon: "checkmark.circle.fill",
                text: "Payment Successful",
                color: .finoraSuccess
            )

            // Error State
            StatusBadge(
                icon: "xmark.circle.fill",
                text: "Transaction Failed",
                color: .finoraError
            )

            // Warning State
            StatusBadge(
                icon: "exclamationmark.triangle.fill",
                text: "Low Balance Alert",
                color: .finoraWarning
            )

            // Info State
            StatusBadge(
                icon: "info.circle.fill",
                text: "Account Verification Pending",
                color: .finoraInfo
            )

            // Security State
            StatusBadge(
                icon: "lock.shield.fill",
                text: "Bank-Level Encryption Active",
                color: .finoraSecurity
            )
        }
    }
}

struct StatusBadge: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 16, weight: .semibold))

            Text(text)
                .font(.subheadline)
                .foregroundColor(.finoraTextPrimary)

            Spacer()
        }
        .padding(12)
        .background(color.opacity(0.1))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Example: Financial Chart Card

struct FinancialChartCardExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text("Spending by Category")
                    .font(.headline)
                    .foregroundColor(.finoraTextPrimary)

                Spacer()

                Text("This Month")
                    .font(.caption)
                    .foregroundColor(.finoraTextSecondary)
            }

            // Category Breakdown
            VStack(spacing: 12) {
                CategoryBar(
                    name: "Food & Dining",
                    amount: 1250,
                    percentage: 0.35,
                    color: .finoraExpense
                )

                CategoryBar(
                    name: "Transportation",
                    amount: 680,
                    percentage: 0.20,
                    color: .finoraInfo
                )

                CategoryBar(
                    name: "Shopping",
                    amount: 920,
                    percentage: 0.25,
                    color: .finoraWarning
                )

                CategoryBar(
                    name: "Bills & Utilities",
                    amount: 450,
                    percentage: 0.12,
                    color: .finoraSecurity
                )

                CategoryBar(
                    name: "Other",
                    amount: 300,
                    percentage: 0.08,
                    color: .finoraTextTertiary
                )
            }
        }
        .padding(20)
        .background(Color.finoraSurface)
        .cornerRadius(16)
        .finoraCardShadow()
    }
}

struct CategoryBar: View {
    let name: String
    let amount: Double
    let percentage: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(.finoraTextPrimary)

                Spacer()

                Text("$\(Int(amount))")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.finoraTextPrimary)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background bar
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.finoraBorder)
                        .frame(height: 8)

                    // Filled bar
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: geometry.size.width * percentage, height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}

// MARK: - Example: Security Badge

struct SecurityBadgeExample: View {
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.finoraSecurity.opacity(0.12))
                    .frame(width: 56, height: 56)

                Image(systemName: "lock.shield.fill")
                    .foregroundColor(.finoraSecurity)
                    .font(.title2)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("256-bit Encryption")
                    .font(.headline)
                    .foregroundColor(.finoraTextPrimary)

                Text("Your data is protected with bank-level security")
                    .font(.caption)
                    .foregroundColor(.finoraTextSecondary)
            }

            Spacer()
        }
        .padding(16)
        .background(Color.finoraSurface)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.finoraSecurity.opacity(0.2), lineWidth: 1.5)
        )
    }
}

// MARK: - Preview

#Preview("Finora Color System Examples") {
    FinoraAppExample()
}

#Preview("Balance Card") {
    BalanceCardExample()
        .padding()
        .background(Color.finoraBackground)
}

#Preview("AI Insight") {
    AIInsightCardExample()
        .padding()
        .background(Color.finoraBackground)
}

#Preview("Chart Card") {
    FinancialChartCardExample()
        .padding()
        .background(Color.finoraBackground)
}

#Preview("Security Badge") {
    SecurityBadgeExample()
        .padding()
        .background(Color.finoraBackground)
}

#Preview("Dark Mode") {
    FinoraAppExample()
        .preferredColorScheme(.dark)
}
