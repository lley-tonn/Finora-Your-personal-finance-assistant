//
//  AuthViewModel.swift
//  Finora
//
//  Manages authentication state and operations
//  Placeholder for future authentication logic
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var biometricEnabled = false

    // MARK: - Authentication Methods

    func login(email: String, password: String) async throws {
        // TODO: Implement login with backend/blockchain
        isAuthenticated = true
    }

    func register(email: String, password: String) async throws {
        // TODO: Implement registration
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
}

// MARK: - User Model (Placeholder)

struct User {
    let id: String
    let email: String
    let publicKey: String
}
