//
//  KeyGenerationView.swift
//  Finora
//
//  Generates decentralized identity keys for user
//  Critical step for data ownership and encryption
//

import SwiftUI

struct KeyGenerationView: View {

    @EnvironmentObject private var router: AppRouter
    @State private var isGenerating = false
    @State private var keysGenerated = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            if isGenerating {
                VStack(spacing: 24) {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.finoraPrimary)

                    Text("Generating your encryption keys...")
                        .font(.headline)
                        .foregroundColor(.finoraTextPrimary)

                    Text("This creates your decentralized identity")
                        .font(.subheadline)
                        .foregroundColor(.finoraTextSecondary)
                }
            } else if keysGenerated {
                VStack(spacing: 24) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.finoraSuccess)

                    Text("Keys Generated Successfully!")
                        .font(.title.bold())
                        .foregroundColor(.finoraTextPrimary)

                    Text("Your decentralized identity is ready. Next, let's backup your keys.")
                        .font(.body)
                        .foregroundColor(.finoraTextSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            } else {
                VStack(spacing: 24) {
                    Image(systemName: "key.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.finoraPrimary)

                    Text("Create Your Identity")
                        .font(.title.bold())
                        .foregroundColor(.finoraTextPrimary)

                    Text("We'll generate encryption keys that only you control. These keys secure your financial data.")
                        .font(.body)
                        .foregroundColor(.finoraTextSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            }

            Spacer()

            if !isGenerating {
                Button(action: keysGenerated ? navigateToBackup : generateKeys) {
                    Text(keysGenerated ? "Continue to Backup" : "Generate Keys")
                        .font(.headline)
                        .foregroundColor(.finoraTextOnPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.finoraButtonPrimary)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Identity Setup")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func generateKeys() {
        isGenerating = true

        Task {
            // TODO: Generate keys using EncryptionPlaceholder
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            isGenerating = false
            keysGenerated = true
        }
    }

    private func navigateToBackup() {
        router.navigate(to: .keyBackup)
    }
}

#Preview {
    NavigationStack {
        KeyGenerationView()
            .environmentObject(AppRouter())
    }
}
