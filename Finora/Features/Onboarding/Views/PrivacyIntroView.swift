//
//  PrivacyIntroView.swift
//  Finora
//
//  Explains privacy model and data ownership before registration
//  Critical for building trust and setting expectations
//

import SwiftUI

struct PrivacyIntroView: View {

    // MARK: - Environment

    @EnvironmentObject private var router: AppRouter

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.finoraSecurity)

                    Text("Your Privacy is Our Priority")
                        .font(.largeTitle.bold())
                        .foregroundColor(.finoraTextPrimary)

                    Text("Finora is built with privacy-first technology to ensure you have complete control over your financial data.")
                        .font(.body)
                        .foregroundColor(.finoraTextSecondary)
                }
                .padding(.bottom, 16)

                // Privacy Features
                PrivacyFeatureCard(
                    icon: "key.fill",
                    title: "You Own Your Keys",
                    description: "Your encryption keys never leave your device. We cannot access your data without your permission."
                )

                PrivacyFeatureCard(
                    icon: "server.rack",
                    title: "Decentralized Storage",
                    description: "Data is stored on IPFS/blockchain, not on centralized servers that can be breached."
                )

                PrivacyFeatureCard(
                    icon: "eye.slash.fill",
                    title: "Zero-Knowledge Architecture",
                    description: "Our AI analyzes encrypted data locally. We never see your raw financial information."
                )

                PrivacyFeatureCard(
                    icon: "person.2.fill",
                    title: "Anonymous Benchmarking",
                    description: "Compare with peers using privacy-preserving techniques. Your identity stays hidden."
                )

                Spacer(minLength: 32)

                // Action Buttons
                VStack(spacing: 12) {
                    Button(action: { router.navigate(to: .register) }) {
                        Text("I Understand, Continue")
                            .font(.headline)
                            .foregroundColor(.finoraTextOnPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.finoraButtonPrimary)
                            .cornerRadius(12)
                    }

                    Button(action: { router.navigateBack() }) {
                        Text("Go Back")
                            .font(.subheadline)
                            .foregroundColor(.finoraTextSecondary)
                    }
                }
            }
            .padding(24)
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Privacy First")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Privacy Feature Card

private struct PrivacyFeatureCard: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.finoraSecurity.opacity(0.12))
                    .frame(width: 48, height: 48)

                Image(systemName: icon)
                    .foregroundColor(.finoraSecurity)
                    .font(.title3)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.finoraTextPrimary)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.finoraTextSecondary)
            }
        }
        .padding(16)
        .background(Color.finoraSurface)
        .cornerRadius(12)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        PrivacyIntroView()
            .environmentObject(AppRouter())
    }
}
