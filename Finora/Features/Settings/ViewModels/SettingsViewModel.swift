//
//  SettingsViewModel.swift
//  Finora
//

import Foundation

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var biometricEnabled = false
    @Published var notificationsEnabled = true
    @Published var darkModeEnabled = false

    func exportData() async {
        // TODO: Export encrypted data
    }

    func deleteAllData() async {
        // TODO: Delete from IPFS and local storage
    }

    func toggleBiometric() {
        biometricEnabled.toggle()
        // TODO: Enable/disable biometric
    }
}
