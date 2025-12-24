//
//  MainTabView.swift
//  Finora
//
//  Main navigation container with bottom tab bar
//  Manages tab selection and content switching
//

import SwiftUI

struct MainTabView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter

    @State private var selectedTab: TabItem = .home
    @State private var contentOpacity: Double = 1.0

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            Color.finoraBackground
                .ignoresSafeArea()

            // Content Area
            VStack(spacing: 0) {
                contentView
                    .opacity(contentOpacity)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Spacer for tab bar
                Spacer()
                    .frame(height: 88)
            }

            // Custom Tab Bar
            VStack(spacing: 0) {
                Spacer()

                TabBarView(selectedTab: $selectedTab)
                    .ignoresSafeArea(.keyboard)
            }
        }
        .preferredColorScheme(.dark)
        .onChange(of: selectedTab) { newTab in
            handleTabChange(to: newTab)
        }
    }

    // MARK: - Content View

    @ViewBuilder
    private var contentView: some View {
        switch selectedTab {
        case .home:
            DashboardView()
                .environmentObject(appRouter)
                .transition(.opacity)

        case .budget:
            BudgetPlaceholderView()
                .transition(.opacity)

        case .insights:
            InsightsPlaceholderView()
                .transition(.opacity)

        case .compare:
            ComparePlaceholderView()
                .transition(.opacity)

        case .profile:
            ProfilePlaceholderView()
                .transition(.opacity)
        }
    }

    // MARK: - Actions

    private func handleTabChange(to tab: TabItem) {
        // Subtle content fade during transition
        withAnimation(.easeInOut(duration: 0.15)) {
            contentOpacity = 0.95
        }

        // Restore opacity
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.easeInOut(duration: 0.15)) {
                contentOpacity = 1.0
            }
        }
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
