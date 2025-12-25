//
//  AppState.swift
//  Finora
//
//  Manages global application state including authentication, onboarding, and user session
//  Single source of truth for app-wide state management
//

import SwiftUI

@MainActor
class AppState: ObservableObject {

    // MARK: - Published Properties

    @Published var hasCompletedOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(hasCompletedOnboarding, forKey: "hasCompletedOnboarding")
        }
    }

    @Published var isAuthenticated: Bool = false

    @Published var hasSetupBiometrics: Bool {
        didSet {
            UserDefaults.standard.set(hasSetupBiometrics, forKey: "hasSetupBiometrics")
        }
    }

    @Published var hasBackedUpKeys: Bool {
        didSet {
            UserDefaults.standard.set(hasBackedUpKeys, forKey: "hasBackedUpKeys")
        }
    }

    // MARK: - Initialization

    init() {
        // Load persisted state
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        self.hasSetupBiometrics = UserDefaults.standard.bool(forKey: "hasSetupBiometrics")
        self.hasBackedUpKeys = UserDefaults.standard.bool(forKey: "hasBackedUpKeys")

        // Authentication is session-based, not persisted
        self.isAuthenticated = false
    }

    // MARK: - State Management Methods

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }

    func authenticate() {
        isAuthenticated = true
    }

    func logout() {
        isAuthenticated = false
    }

    func setupBiometrics() {
        hasSetupBiometrics = true
    }

    func backupKeys() {
        hasBackedUpKeys = true
    }

    func resetForDevelopment() {
        hasCompletedOnboarding = false
        isAuthenticated = false
        hasSetupBiometrics = false
        hasBackedUpKeys = false
    }

    // MARK: - Computed Properties

    var needsOnboarding: Bool {
        return !hasCompletedOnboarding
    }

    var needsAuthentication: Bool {
        return hasCompletedOnboarding && !isAuthenticated
    }

    var needsIdentitySetup: Bool {
        return isAuthenticated && !hasBackedUpKeys
    }
}
