//
//  AuthViewModel.swift
//  Finora
//
//  Manages authentication state and UI mode switching
//  Handles login/register form state and transitions
//

import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {

    // MARK: - Published Properties

    // UI State
    @Published var currentMode: AuthMode = .login
    @Published var isTransitioning = false

    // Form Fields - Login
    @Published var loginEmail = ""
    @Published var loginPassword = ""

    // Form Fields - Register
    @Published var registerFullName = ""
    @Published var registerEmail = ""
    @Published var registerPassword = ""
    @Published var registerConfirmPassword = ""

    // Authentication State
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var biometricEnabled = false

    // MARK: - Mode Switching

    func switchMode(to mode: AuthMode) {
        guard currentMode != mode else { return }

        withAnimation(.easeInOut(duration: 0.4)) {
            isTransitioning = true
            currentMode = mode
        }

        // Reset transitioning flag after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation {
                self.isTransitioning = false
            }
        }
    }

    // MARK: - Authentication Methods (Placeholders)

    func login() async throws {
        // TODO: Implement login with backend/blockchain
        // Validate loginEmail and loginPassword
        isAuthenticated = true
    }

    func register() async throws {
        // TODO: Implement registration
        // Validate all register fields
        isAuthenticated = true
    }

    func loginWithBiometric() async throws {
        // TODO: Implement biometric authentication
        isAuthenticated = true
    }

    func logout() {
        isAuthenticated = false
        currentUser = nil
    }

    func enableBiometric() async throws {
        // TODO: Setup biometric authentication
        biometricEnabled = true
    }

    func forgotPassword() {
        // TODO: Implement password reset flow
    }

    // MARK: - Form Validation (Placeholders)

    var isLoginValid: Bool {
        !loginEmail.isEmpty && !loginPassword.isEmpty
    }

    var isRegisterValid: Bool {
        !registerFullName.isEmpty &&
        !registerEmail.isEmpty &&
        !registerPassword.isEmpty &&
        !registerConfirmPassword.isEmpty
    }
}

// MARK: - User Model (Placeholder)

struct User {
    let id: String
    let email: String
    let publicKey: String
}
