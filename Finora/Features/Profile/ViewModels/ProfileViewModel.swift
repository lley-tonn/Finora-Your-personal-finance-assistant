//
//  ProfileViewModel.swift
//  Finora
//
//  Manages profile state and user preferences
//  Handles toggles and navigation
//

import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var userName: String = "Alex Chen"
    @Published var userEmail: String = "alex@private.key"
    @Published var securityStatus: SecurityStatus = .secure

    // Toggle States
    @Published var aiInsightsEnabled: Bool = true
    @Published var peerBenchmarkingEnabled: Bool = false
    @Published var reducedMotionEnabled: Bool = false

    // MARK: - Computed Properties

    var userInitials: String {
        let components = userName.components(separatedBy: " ")
        let firstInitial = components.first?.prefix(1) ?? ""
        let lastInitial = components.last?.prefix(1) ?? ""
        return "\(firstInitial)\(lastInitial)".uppercased()
    }

    var sections: [ProfileSection] {
        ProfileSection.allCases
    }

    // MARK: - Methods

    func toggle(_ type: ProfileToggleType) {
        switch type {
        case .aiInsights:
            aiInsightsEnabled.toggle()
        case .peerBenchmarking:
            peerBenchmarkingEnabled.toggle()
        case .reducedMotion:
            reducedMotionEnabled.toggle()
        }
    }

    func getToggleState(_ type: ProfileToggleType) -> Bool {
        switch type {
        case .aiInsights:
            return aiInsightsEnabled
        case .peerBenchmarking:
            return peerBenchmarkingEnabled
        case .reducedMotion:
            return reducedMotionEnabled
        }
    }

    func signOut() {
        // TODO: Implement sign out logic
        print("Sign out requested")
    }

    func deleteAccount() {
        // TODO: Implement account deletion
        print("Delete account requested")
    }
}

// MARK: - Security Status

enum SecurityStatus {
    case secure
    case backupPending
    case actionRequired

    var text: String {
        switch self {
        case .secure:
            return "Secure"
        case .backupPending:
            return "Backup Pending"
        case .actionRequired:
            return "Action Required"
        }
    }

    var color: Color {
        switch self {
        case .secure:
            return .finoraSuccess
        case .backupPending:
            return .finoraWarning
        case .actionRequired:
            return .finoraExpense
        }
    }

    var icon: String {
        switch self {
        case .secure:
            return "checkmark.shield.fill"
        case .backupPending:
            return "exclamationmark.shield.fill"
        case .actionRequired:
            return "exclamationmark.triangle.fill"
        }
    }
}
