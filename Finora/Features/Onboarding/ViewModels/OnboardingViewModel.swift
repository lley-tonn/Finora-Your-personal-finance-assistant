//
//  OnboardingViewModel.swift
//  Finora
//
//  Manages onboarding state and user preferences
//  Placeholder for future onboarding logic
//

import Foundation

@MainActor
class OnboardingViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var hasCompletedOnboarding = false
    @Published var hasSeenPrivacyIntro = false

    // MARK: - Methods

    /// Mark onboarding as completed
    func completeOnboarding() {
        hasCompletedOnboarding = true
        // TODO: Persist to UserDefaults or encrypted storage
    }

    /// Mark privacy intro as seen
    func markPrivacyIntroSeen() {
        hasSeenPrivacyIntro = true
        // TODO: Persist to UserDefaults or encrypted storage
    }

    /// Check if user should see onboarding
    func shouldShowOnboarding() -> Bool {
        // TODO: Check persisted state
        return !hasCompletedOnboarding
    }
}
