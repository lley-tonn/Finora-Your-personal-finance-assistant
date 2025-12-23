//
//  AppState.swift
//  Finora
//
//  App-wide state management
//

import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    @Published var isLoading: Bool = false
    
    private let sessionManager: SessionManager
    
    init(sessionManager: SessionManager = SessionManager.shared) {
        self.sessionManager = sessionManager
        checkAuthenticationStatus()
    }
    
    private func checkAuthenticationStatus() {
        isAuthenticated = sessionManager.isAuthenticated
        currentUser = sessionManager.currentUser
    }
}

