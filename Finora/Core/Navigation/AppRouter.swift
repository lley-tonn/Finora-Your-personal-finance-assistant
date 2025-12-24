//
//  AppRouter.swift
//  Finora
//
//  Central navigation coordinator for the entire app
//  Manages navigation state and provides navigation methods
//

import SwiftUI

@MainActor
class AppRouter: ObservableObject {

    // MARK: - Properties

    @Published var path = NavigationPath()

    // MARK: - Navigation Methods

    /// Navigate to a specific route
    func navigate(to route: AppRoute) {
        path.append(route)
    }

    /// Navigate back one screen
    func navigateBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    /// Navigate back to root (clear entire stack)
    func navigateToRoot() {
        path = NavigationPath()
    }

    /// Replace entire navigation stack with new route
    func replaceStack(with route: AppRoute) {
        path = NavigationPath()
        path.append(route)
    }

    /// Navigate back N screens
    func navigateBack(count: Int) {
        guard path.count >= count else {
            navigateToRoot()
            return
        }
        for _ in 0..<count {
            path.removeLast()
        }
    }
}

// MARK: - Convenience Navigation Extensions

extension AppRouter {

    /// Complete onboarding flow and navigate to authentication
    func completeOnboarding() {
        replaceStack(with: .login)
    }

    /// Complete authentication and navigate to identity setup
    func completeAuthentication() {
        navigate(to: .keyGeneration)
    }

    /// Complete identity setup and navigate to dashboard
    func completeIdentitySetup() {
        replaceStack(with: .dashboard)
    }

    /// Logout and return to login
    func logout() {
        replaceStack(with: .login)
    }
}
