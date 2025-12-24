//
//  OnboardingView.swift
//  Finora
//
//  Onboarding carousel showing key app features and value propositions
//  Educates users about AI insights, privacy, and financial management
//

import SwiftUI

struct OnboardingView: View {

    // MARK: - Environment

    @EnvironmentObject private var router: AppRouter

    // MARK: - State

    @State private var currentPage = 0

    // MARK: - Constants

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "brain.head.profile",
            title: "AI-Powered Insights",
            description: "Get personalized financial advice powered by intelligent algorithms"
        ),
        OnboardingPage(
            icon: "lock.shield.fill",
            title: "Your Data, Your Control",
            description: "Decentralized storage means you own and control your financial data"
        ),
        OnboardingPage(
            icon: "chart.bar.fill",
            title: "Smart Budgeting",
            description: "Track spending, set goals, and optimize your financial health"
        ),
        OnboardingPage(
            icon: "person.2.fill",
            title: "Anonymous Benchmarking",
            description: "Compare your progress with similar users while staying private"
        )
    ]

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            // Page Carousel
            TabView(selection: $currentPage) {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    SimpleOnboardingPage(page: page)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            // Navigation Buttons
            VStack(spacing: 16) {
                if currentPage == pages.count - 1 {
                    // Get Started button on last page
                    Button(action: getStarted) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundColor(.finoraTextOnPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.finoraButtonPrimary)
                            .cornerRadius(12)
                    }

                    Button(action: { router.navigate(to: .login) }) {
                        Text("I Already Have an Account")
                            .font(.subheadline)
                            .foregroundColor(.finoraLink)
                    }
                } else {
                    // Next button on other pages
                    Button(action: nextPage) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.finoraTextOnPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.finoraButtonPrimary)
                            .cornerRadius(12)
                    }

                    Button(action: skipOnboarding) {
                        Text("Skip")
                            .font(.subheadline)
                            .foregroundColor(.finoraTextSecondary)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.finoraBackground.ignoresSafeArea())
    }

    // MARK: - Methods

    private func nextPage() {
        withAnimation {
            currentPage += 1
        }
    }

    private func skipOnboarding() {
        router.navigate(to: .privacyIntro)
    }

    private func getStarted() {
        router.navigate(to: .privacyIntro)
    }
}

// MARK: - Simple Onboarding Page View

private struct SimpleOnboardingPage: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            // Icon
            ZStack {
                Circle()
                    .fill(LinearGradient.finoraAIGradient)
                    .frame(width: 140, height: 140)

                Image(systemName: page.icon)
                    .font(.system(size: 60))
                    .foregroundColor(.white)
            }

            // Content
            VStack(spacing: 16) {
                Text(page.title)
                    .font(.title.bold())
                    .foregroundColor(.finoraTextPrimary)
                    .multilineTextAlignment(.center)

                Text(page.description)
                    .font(.body)
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()
        }
    }
}

// MARK: - Models

private struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
}

// MARK: - Preview

#Preview {
    OnboardingView()
        .environmentObject(AppRouter())
}
