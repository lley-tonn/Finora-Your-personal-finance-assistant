//
//  DashboardView.swift
//  Finora
//
//  Premium dashboard with staggered animations and refined cards
//  Main hub for financial overview and AI insights
//

import SwiftUI

struct DashboardView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter

    // Animation States
    @State private var headerOpacity: Double = 0
    @State private var balanceOpacity: Double = 0
    @State private var balanceOffset: CGFloat = 20
    @State private var insightOpacity: Double = 0
    @State private var budgetOpacity: Double = 0
    @State private var actionsOpacity: Double = 0
    @State private var transactionsOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background
            Color.finoraBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    header
                        .opacity(headerOpacity)
                        .padding(.top, 16)

                    // Net Worth Card
                    netWorthCard
                        .opacity(balanceOpacity)
                        .offset(y: balanceOffset)

                    // AI Insight Card
                    aiInsightCard
                        .opacity(insightOpacity)

                    // Budget Overview
                    budgetOverviewCard
                        .opacity(budgetOpacity)

                    // Quick Actions
                    quickActionsGrid
                        .opacity(actionsOpacity)

                    // Recent Transactions
                    recentTransactionsSection
                        .opacity(transactionsOpacity)

                    // Bottom spacing
                    Spacer()
                        .frame(height: 40)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarBackButtonHidden()
        .preferredColorScheme(.dark)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)

                Text("Financial Overview")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)
            }

            Spacer()

            Button(action: {
                appRouter.navigate(to: .settings)
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.finoraTextSecondary)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(Color.finoraSurface)
                    )
            }
        }
    }

    // MARK: - Net Worth Card

    private var netWorthCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Label
            Text("Net Worth")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraTextSecondary)

            // Balance
            Text("$24,567.89")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.finoraTextPrimary)

            // Change indicator
            HStack(spacing: 6) {
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 14, weight: .semibold))

                Text("+$1,245.50")
                    .font(.system(size: 15, weight: .semibold))

                Text("(+5.3%)")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)

                Text("this month")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.finoraTextTertiary)
            }
            .foregroundColor(.finoraSuccess)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.finoraSurfaceElevated,
                            Color.finoraSurface
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .finoraCardShadow()
    }

    // MARK: - AI Insight Card

    private var aiInsightCard: some View {
        Button(action: {
            appRouter.navigate(to: .aiChat)
        }) {
            HStack(spacing: 16) {
                // AI Icon
                ZStack {
                    Circle()
                        .fill(LinearGradient.finoraAIGradient)
                        .frame(width: 52, height: 52)

                    Image(systemName: "sparkles")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }

                // Content
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Text("AI Insight")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.finoraAIAccent)

                        Image(systemName: "wand.and.stars")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.finoraAIAccent)
                    }

                    Text("You're on track to save $1,200 this month")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.finoraTextPrimary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Tap for details")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.finoraTextTertiary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.finoraTextTertiary)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.finoraAIInsightBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.finoraAIAccent.opacity(0.3),
                                Color.finoraAIAccent.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
            )
        }
    }

    // MARK: - Budget Overview Card

    private var budgetOverviewCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Monthly Budget")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                Spacer()

                Button(action: {
                    appRouter.navigate(to: .budgetOverview)
                }) {
                    Text("View All")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.finoraLink)
                }
            }

            // Budget progress
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("$3,245 spent")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.finoraTextPrimary)

                    Spacer()

                    Text("$1,755 left")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)
                }

                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.finoraBorder.opacity(0.2))
                            .frame(height: 12)

                        // Progress
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(
                                    colors: [Color.finoraExpense, Color.finoraExpense.opacity(0.8)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * 0.65, height: 12)
                    }
                }
                .frame(height: 12)

                Text("65% of budget used")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.finoraTextTertiary)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.finoraSurface)
        )
    }

    // MARK: - Quick Actions Grid

    private var quickActionsGrid: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Actions")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.finoraTextPrimary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                quickActionButton(
                    icon: "chart.bar.fill",
                    title: "Budgeting",
                    color: .finoraExpense
                ) {
                    appRouter.navigate(to: .budgetOverview)
                }

                quickActionButton(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Investments",
                    color: .finoraInvestment
                ) {
                    appRouter.navigate(to: .investmentOverview)
                }

                quickActionButton(
                    icon: "creditcard.fill",
                    title: "Debt",
                    color: .finoraWarning
                ) {
                    appRouter.navigate(to: .debtOverview)
                }

                quickActionButton(
                    icon: "person.2.fill",
                    title: "Compare",
                    color: .finoraInfo
                ) {
                    appRouter.navigate(to: .peerComparison)
                }
            }
        }
    }

    private func quickActionButton(icon: String, title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 26))
                    .foregroundColor(color)

                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextPrimary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.finoraSurface)
            )
        }
    }

    // MARK: - Recent Transactions Section

    private var recentTransactionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Activity")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                Spacer()

                Button(action: {
                    // Navigate to full transaction list
                }) {
                    Text("See All")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.finoraLink)
                }
            }

            VStack(spacing: 12) {
                transactionRow(
                    icon: "cart.fill",
                    iconColor: .finoraExpense,
                    title: "Whole Foods",
                    category: "Groceries",
                    amount: "-$87.50"
                )

                transactionRow(
                    icon: "cup.and.saucer.fill",
                    iconColor: .finoraExpense,
                    title: "Starbucks",
                    category: "Coffee & Dining",
                    amount: "-$6.75"
                )

                transactionRow(
                    icon: "arrow.down.circle.fill",
                    iconColor: .finoraIncome,
                    title: "Salary Deposit",
                    category: "Income",
                    amount: "+$3,500.00"
                )
            }
        }
    }

    private func transactionRow(icon: String, iconColor: Color, title: String, category: String, amount: String) -> some View {
        HStack(spacing: 14) {
            // Icon
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 44, height: 44)

                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(iconColor)
            }

            // Details
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.finoraTextPrimary)

                Text(category)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
            }

            Spacer()

            // Amount
            Text(amount)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(amount.hasPrefix("+") ? .finoraIncome : .finoraTextPrimary)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.finoraSurface)
        )
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Header
        withAnimation(.easeInOut(duration: 0.6)) {
            headerOpacity = 1.0
        }

        // Balance card
        withAnimation(.easeInOut(duration: 0.8).delay(0.1)) {
            balanceOpacity = 1.0
            balanceOffset = 0
        }

        // AI Insight
        withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
            insightOpacity = 1.0
        }

        // Budget
        withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
            budgetOpacity = 1.0
        }

        // Quick Actions
        withAnimation(.easeInOut(duration: 0.8).delay(0.4)) {
            actionsOpacity = 1.0
        }

        // Recent Transactions
        withAnimation(.easeInOut(duration: 0.8).delay(0.5)) {
            transactionsOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    DashboardView()
        .environmentObject(AppRouter())
}
