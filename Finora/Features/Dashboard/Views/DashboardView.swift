//
//  DashboardView.swift
//  Finora
//
//  Main dashboard showing financial overview and AI insights
//

import SwiftUI

struct DashboardView: View {

    @EnvironmentObject private var router: AppRouter

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back!")
                            .font(.title2.bold())
                            .foregroundColor(.finoraTextPrimary)

                        Text("Here's your financial overview")
                            .font(.subheadline)
                            .foregroundColor(.finoraTextSecondary)
                    }

                    Spacer()

                    Button(action: { router.navigate(to: .settings) }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.finoraTextPrimary)
                    }
                }

                // Balance Card
                BalanceCard()

                // AI Insights
                InsightCardView()

                // Quick Actions
                QuickActionsGrid(router: router)

                // Recent Activity
                RecentActivitySection()
            }
            .padding()
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationBarBackButtonHidden()
    }
}

// MARK: - Balance Card

private struct BalanceCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Total Balance")
                .font(.subheadline)
                .foregroundColor(.finoraTextSecondary)

            Text("$24,567.89")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.finoraTextPrimary)

            HStack(spacing: 6) {
                Image(systemName: "arrow.up.right")
                Text("+12.5%")
                    .fontWeight(.semibold)
                Text("this month")
                    .foregroundColor(.finoraTextSecondary)
            }
            .font(.subheadline)
            .foregroundColor(.finoraSuccess)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color.finoraSurface)
        .cornerRadius(16)
        .finoraCardShadow()
    }
}

// MARK: - Quick Actions

private struct QuickActionsGrid: View {
    let router: AppRouter

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            QuickActionButton(icon: "chart.bar.fill", title: "Budget", color: .finoraExpense) {
                router.navigate(to: .budgetOverview)
            }

            QuickActionButton(icon: "chart.line.uptrend.xyaxis", title: "Invest", color: .finoraInvestment) {
                router.navigate(to: .investmentOverview)
            }

            QuickActionButton(icon: "creditcard.fill", title: "Debt", color: .finoraWarning) {
                router.navigate(to: .debtOverview)
            }

            QuickActionButton(icon: "person.2.fill", title: "Compare", color: .finoraInfo) {
                router.navigate(to: .peerComparison)
            }
        }
    }
}

private struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(color)

                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.finoraTextPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .background(Color.finoraSurface)
            .cornerRadius(12)
        }
    }
}

// MARK: - Recent Activity

private struct RecentActivitySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Activity")
                .font(.headline)
                .foregroundColor(.finoraTextPrimary)

            ForEach(0..<3) { _ in
                HStack {
                    Circle()
                        .fill(Color.finoraExpense.opacity(0.12))
                        .frame(width: 40, height: 40)
                        .overlay(Image(systemName: "cart.fill").foregroundColor(.finoraExpense))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Grocery Store")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.finoraTextPrimary)

                        Text("Food & Dining")
                            .font(.caption)
                            .foregroundColor(.finoraTextSecondary)
                    }

                    Spacer()

                    Text("-$87.50")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.finoraTextPrimary)
                }
                .padding()
                .background(Color.finoraSurface)
                .cornerRadius(12)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView()
            .environmentObject(AppRouter())
    }
}
