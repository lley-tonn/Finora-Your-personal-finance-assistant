//
//  IdentityViewModel.swift
//  Finora
//
//  Manages decentralized identity and key management
//

import Foundation

@MainActor
class IdentityViewModel: ObservableObject {

    @Published var publicKey: String?
    @Published var hasBackedUpKeys = false

    func generateKeys() async throws {
        // TODO: Use EncryptionPlaceholder to generate keys
        publicKey = "did:example:123456789"
    }

    func backupKeys() {
        hasBackedUpKeys = true
        // TODO: Persist backup status
    }
}
