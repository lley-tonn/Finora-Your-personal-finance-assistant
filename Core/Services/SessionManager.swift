//
//  SessionManager.swift
//  Finora
//
//  Manages user session and authentication state
//

import Foundation
import Combine

final class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    
    private let userDefaults: UserDefaults
    private let authTokenKey = "auth_token"
    private let userDataKey = "user_data"
    
    var authToken: String? {
        userDefaults.string(forKey: authTokenKey)
    }
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        loadSession()
    }
    
    func saveSession(token: String, user: User) {
        userDefaults.set(token, forKey: authTokenKey)
        if let userData = try? JSONEncoder().encode(user) {
            userDefaults.set(userData, forKey: userDataKey)
        }
        isAuthenticated = true
        currentUser = user
    }
    
    func clearSession() {
        userDefaults.removeObject(forKey: authTokenKey)
        userDefaults.removeObject(forKey: userDataKey)
        isAuthenticated = false
        currentUser = nil
    }
    
    private func loadSession() {
        if let _ = authToken,
           let userData = userDefaults.data(forKey: userDataKey),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            isAuthenticated = true
            currentUser = user
        }
    }
}

