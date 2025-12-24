//
//  BiometricSetupView.swift
//  Finora
//
//  Biometric authentication setup (Face ID / Touch ID)
//  Optional security enhancement for quick login
//

import SwiftUI

struct BiometricSetupView: View {

    @EnvironmentObject private var router: AppRouter
    @State private var biometricEnabled = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            // Icon
            Image(systemName: "faceid")
                .font(.system(size: 100))
                .foregroundColor(.finoraPrimary)

            // Content
            VStack(spacing: 16) {
                Text("Enable Biometric Login")
                    .font(.title.bold())
                    .foregroundColor(.finoraTextPrimary)

                Text("Use Face ID or Touch ID for quick and secure access to your financial data")
                    .font(.body)
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()

            // Buttons
            VStack(spacing: 12) {
                Button(action: enableBiometric) {
                    Text("Enable Biometric Login")
                        .font(.headline)
                        .foregroundColor(.finoraTextOnPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.finoraButtonPrimary)
                        .cornerRadius(12)
                }

                Button(action: skip) {
                    Text("Skip for Now")
                        .font(.subheadline)
                        .foregroundColor(.finoraTextSecondary)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Biometric Setup")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func enableBiometric() {
        // TODO: Implement biometric setup
        biometricEnabled = true
        router.completeAuthentication()
    }

    private func skip() {
        router.completeAuthentication()
    }
}

#Preview {
    NavigationStack {
        BiometricSetupView()
            .environmentObject(AppRouter())
    }
}
