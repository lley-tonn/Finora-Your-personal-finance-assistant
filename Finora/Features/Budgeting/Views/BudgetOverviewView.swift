//
//  BudgetOverviewView.swift
//  Finora
//
//  Premium budget overview with category breakdowns
//  Track spending across multiple budget categories
//

import SwiftUI

struct BudgetOverviewView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter

    // Animation States
    @State private var headerOpacity: Double = 0
    @State private var summaryOpacity: Double = 0
    @State private var categoriesOpacity: Double = 0
    @State private var ctaOpacity: Double = 0

    // MARK: - Sample Data

    private let budgetCategories = [
        BudgetCategory(name: "Groceries", allocated: 600, spent: 450, icon: "cart.fill", color: "expense"),
        BudgetCategory(name: "Dining Out", allocated: 300, spent: 280, icon: "fork.knife", color: "expense"),
        BudgetCategory(name: "Transportation", allocated: 200, spent: 150, icon: "car.fill", color: "info"),
        BudgetCategory(name: "Entertainment", allocated: 150, spent: 120, icon: "film.fill", color: "ai"),
        BudgetCategory(name: "Shopping", allocated: 250, spent: 200, icon: "bag.fill", color: "warning"),
        BudgetCategory(name: "Health", allocated: 100, spent: 80, icon: "heart.fill", color: "success"),
    ]

    private var totalSpent: Double {
        budgetCategories.reduce(0) { $0 + $1.spent }
    }

    private var totalLimit: Double {
        budgetCategories.reduce(0) { $0 + $1.allocated }
    }

    private var spentPercentage: Double {
        totalLimit > 0 ? totalSpent / totalLimit : 0
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background
            Color.finoraBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Top spacing
                    Spacer()
                        .frame(height: 16)

                    // Header
                    header
                        .opacity(headerOpacity)
                        .padding(.horizontal, 24)

                    // Summary Card
                    summaryCard
                        .opacity(summaryOpacity)
                        .padding(.horizontal, 24)

                    // Categories Section
                    categoriesSection
                        .opacity(categoriesOpacity)
                        .padding(.horizontal, 24)

                    // Edit Budget CTA
                    editBudgetButton
                        .opacity(ctaOpacity)
                        .padding(.horizontal, 24)

                    // Bottom spacing
                    Spacer()
                        .frame(height: 100)
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Budget Overview")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                Text("Track your monthly spending")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
            }

            Spacer()
        }
    }

    // MARK: - Summary Card

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            Text("Monthly Total")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraTextSecondary)

            // Amount
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("$\(Int(totalSpent))")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.finoraTextPrimary)

                Text("/ $\(Int(totalLimit))")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(.finoraTextSecondary)
            }

            // Progress bar
            VStack(alignment: .leading, spacing: 8) {
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
                                    colors: progressGradientColors,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * spentPercentage, height: 12)
                    }
                }
                .frame(height: 12)

                // Percentage text
                Text("\(Int(spentPercentage * 100))% of budget used")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.finoraTextTertiary)
            }

            // Remaining amount
            HStack(spacing: 6) {
                Image(systemName: remainingIcon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(remainingColor)

                Text("$\(Int(totalLimit - totalSpent)) remaining")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(remainingColor)
            }
            .padding(.top, 4)
        }
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

    // MARK: - Categories Section

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Categories")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.finoraTextPrimary)

            VStack(spacing: 12) {
                ForEach(budgetCategories) { category in
                    categoryRow(category)
                }
            }
        }
    }

    private func categoryRow(_ category: BudgetCategory) -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                // Icon
                ZStack {
                    Circle()
                        .fill(categoryColor(for: category.color).opacity(0.15))
                        .frame(width: 44, height: 44)

                    Image(systemName: category.icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(categoryColor(for: category.color))
                }

                // Details
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(category.name)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.finoraTextPrimary)

                        Spacer()

                        Text("$\(Int(category.spent)) / $\(Int(category.allocated))")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.finoraTextPrimary)
                    }

                    // Progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            // Background
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.finoraBorder.opacity(0.15))
                                .frame(height: 6)

                            // Progress
                            RoundedRectangle(cornerRadius: 4)
                                .fill(categoryColor(for: category.color))
                                .frame(width: geometry.size.width * category.percentage, height: 6)
                        }
                    }
                    .frame(height: 6)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.finoraSurface)
        )
    }

    // MARK: - Helper

    private func categoryColor(for colorName: String) -> Color {
        switch colorName {
        case "expense":
            return .finoraExpense
        case "info":
            return .finoraInfo
        case "ai":
            return .finoraAIAccent
        case "warning":
            return .finoraWarning
        case "success":
            return .finoraSuccess
        default:
            return .finoraTextPrimary
        }
    }

    // MARK: - Edit Budget Button

    private var editBudgetButton: some View {
        Button(action: {
            appRouter.navigate(to: .budgetEdit)
        }) {
            HStack(spacing: 8) {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Text("Edit Budget")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    colors: [Color.finoraExpense, Color.finoraExpense.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .shadow(
                color: Color.finoraExpense.opacity(0.3),
                radius: 16,
                x: 0,
                y: 8
            )
        }
    }

    // MARK: - Computed Properties

    private var progressGradientColors: [Color] {
        if spentPercentage < 0.7 {
            return [Color.finoraSuccess, Color.finoraSuccess.opacity(0.8)]
        } else if spentPercentage < 0.9 {
            return [Color.finoraWarning, Color.finoraWarning.opacity(0.8)]
        } else {
            return [Color.finoraExpense, Color.finoraExpense.opacity(0.8)]
        }
    }

    private var remainingColor: Color {
        if spentPercentage < 0.7 {
            return .finoraSuccess
        } else if spentPercentage < 0.9 {
            return .finoraWarning
        } else {
            return .finoraExpense
        }
    }

    private var remainingIcon: String {
        if spentPercentage < 0.9 {
            return "checkmark.circle.fill"
        } else {
            return "exclamationmark.triangle.fill"
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Header
        withAnimation(.easeInOut(duration: 0.6)) {
            headerOpacity = 1.0
        }

        // Summary
        withAnimation(.easeInOut(duration: 0.8).delay(0.1)) {
            summaryOpacity = 1.0
        }

        // Categories
        withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
            categoriesOpacity = 1.0
        }

        // CTA
        withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
            ctaOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    BudgetOverviewView()
        .environmentObject(AppRouter())
}
