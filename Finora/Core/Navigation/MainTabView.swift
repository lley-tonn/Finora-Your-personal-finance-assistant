//
//  MainTabView.swift
//  Finora
//
//  Main navigation container with native bottom tab bar
//  Minimal, flush-to-bottom design
//

import SwiftUI

struct MainTabView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @State private var selectedTab: TabItem = .home

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            DashboardView()
                .environmentObject(appRouter)
                .tabItem {
                    Label(TabItem.home.label, systemImage: TabItem.home.iconName)
                }
                .tag(TabItem.home)

            // Budget Tab
            BudgetOverviewView()
                .environmentObject(appRouter)
                .tabItem {
                    Label(TabItem.budget.label, systemImage: TabItem.budget.iconName)
                }
                .tag(TabItem.budget)

            // Insights Tab
            InsightsPlaceholderView()
                .tabItem {
                    Label(TabItem.insights.label, systemImage: TabItem.insights.iconName)
                }
                .tag(TabItem.insights)

            // Compare Tab
            ComparePlaceholderView()
                .tabItem {
                    Label(TabItem.compare.label, systemImage: TabItem.compare.iconName)
                }
                .tag(TabItem.compare)

            // Profile Tab
            ProfileView()
                .environmentObject(appRouter)
                .tabItem {
                    Label(TabItem.profile.label, systemImage: TabItem.profile.iconName)
                }
                .tag(TabItem.profile)
        }
        .tint(.finoraAIAccent)
        .preferredColorScheme(.dark)
    }
}

// MARK: - Placeholder Views

struct BudgetPlaceholderView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 60)

                // Icon
                Image(systemName: "wallet.pass.fill")
                    .font(.system(size: 64, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.finoraExpense, Color.finoraExpense.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(.bottom, 24)

                // Title
                Text("Budget Overview")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                // Description
                Text("Track your spending and manage budgets")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)

                Spacer()
            }
        }
        .background(Color.finoraBackground)
    }
}

struct InsightsPlaceholderView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 60)

                // Icon
                Image(systemName: "sparkles")
                    .font(.system(size: 64, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.finoraAIAccent, Color.finoraAIAccent.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(.bottom, 24)

                // Title
                Text("AI Insights")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                // Description
                Text("Personalized financial guidance and predictions")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)

                Spacer()
            }
        }
        .background(Color.finoraBackground)
    }
}

struct ComparePlaceholderView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 60)

                // Icon
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 64, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.finoraInfo, Color.finoraInfo.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(.bottom, 24)

                // Title
                Text("Peer Comparison")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                // Description
                Text("Anonymous benchmarking with similar users")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)

                Spacer()
            }
        }
        .background(Color.finoraBackground)
    }
}

struct ProfilePlaceholderView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 60)

                // Icon
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 64, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.finoraSecurity, Color.finoraSecurity.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(.bottom, 24)

                // Title
                Text("Profile & Settings")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                // Description
                Text("Manage your account, security, and preferences")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)

                Spacer()
            }
        }
        .background(Color.finoraBackground)
    }
}

// MARK: - Preview

#Preview {
    MainTabView()
        .environmentObject(AppRouter())
}
