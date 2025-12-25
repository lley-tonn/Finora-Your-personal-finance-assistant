//
//  BiometricSetupView.swift
//  Finora
//
//  Premium biometric authentication setup with refined animations
//  Optional security enhancement for quick, secure login
//

import SwiftUI

struct BiometricSetupView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @EnvironmentObject private var appState: AppState

    @State private var iconOpacity: Double = 0
    @State private var iconScale: CGFloat = 0.8
    @State private var headlineOpacity: Double = 0
    @State private var headlineOffset: CGFloat = 20
    @State private var bodyOpacity: Double = 0
    @State private var bodyOffset: CGFloat = 20
    @State private var featuresOpacity: Double = 0
    @State private var ctaOpacity: Double = 0
    @State private var ctaOffset: CGFloat = 12
    @State private var skipOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.finoraBackground,
                    Color.finoraBackground.opacity(0.95),
                    Color.finoraSecurity.opacity(0.04)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Biometric Icon
                ZStack {
                    // Glow effect
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.finoraSecurity.opacity(0.2),
                                    Color.finoraSecurity.opacity(0.0)
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 80
                            )
                        )
                        .frame(width: 160, height: 160)

                    // Icon
                    Image(systemName: "faceid")
                        .font(.system(size: 72, weight: .light))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.finoraSecurity,
                                    Color.finoraSecurity.opacity(0.8)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .opacity(iconOpacity)
                .scaleEffect(iconScale)
                .padding(.bottom, 48)

                // Headline
                Text("Secure Your Access")
                    .font(.system(size: 32, weight: .semibold, design: .default))
                    .foregroundColor(.finoraTextPrimary)
                    .multilineTextAlignment(.center)
                    .opacity(headlineOpacity)
                    .offset(y: headlineOffset)
                    .padding(.bottom, 16)

                // Body Text
                Text("Enable Face ID or Touch ID for instant, secure access to your financial insights.")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .opacity(bodyOpacity)
                    .offset(y: bodyOffset)
                    .padding(.bottom, 40)

                // Security Features
                securityFeatures
                    .opacity(featuresOpacity)

                Spacer()

                // CTA Button
                Button(action: {
                    enableBiometric()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.shield.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)

                        Text("Enable Biometric Login")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.finoraSecurity,
                                Color.finoraSecurity.opacity(0.8)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                    .shadow(
                        color: Color.finoraSecurity.opacity(0.3),
                        radius: 16,
                        x: 0,
                        y: 8
                    )
                }
                .opacity(ctaOpacity)
                .offset(y: ctaOffset)
                .padding(.horizontal, 32)
                .padding(.bottom, 16)

                // Skip Button
                Button(action: {
                    skip()
                }) {
                    Text("Skip for Now")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.finoraTextTertiary)
                }
                .opacity(skipOpacity)
                .padding(.bottom, 48)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Security Features

    private var securityFeatures: some View {
        VStack(spacing: 16) {
            featureRow(
                icon: "lock.shield.fill",
                title: "Bank-Level Security",
                description: "Your biometric data never leaves your device"
            )

            featureRow(
                icon: "bolt.fill",
                title: "Instant Access",
                description: "Login in under a second with Face ID"
            )

            featureRow(
                icon: "hand.raised.fill",
                title: "Complete Control",
                description: "Disable anytime in Settings"
            )
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 32)
    }

    private func featureRow(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.finoraSecurity)
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                Text(description)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
            }
        }
    }

    // MARK: - Actions

    private func enableBiometric() {
        // Mark biometrics as set up
        appState.setupBiometrics()
        // TODO: Implement actual biometric setup
        // Navigate to main app
        appRouter.navigate(to: .mainTab)
    }

    private func skip() {
        // Skip biometric setup and continue to main app
        appRouter.navigate(to: .mainTab)
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Icon with scale + fade
        withAnimation(.easeInOut(duration: 0.8)) {
            iconOpacity = 1.0
            iconScale = 1.0
        }

        // Headline
        withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
            headlineOpacity = 1.0
            headlineOffset = 0
        }

        // Body
        withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
            bodyOpacity = 1.0
            bodyOffset = 0
        }

        // Features
        withAnimation(.easeInOut(duration: 0.8).delay(0.4)) {
            featuresOpacity = 1.0
        }

        // CTA Button
        withAnimation(.easeInOut(duration: 0.8).delay(0.5)) {
            ctaOpacity = 1.0
            ctaOffset = 0
        }

        // Skip button
        withAnimation(.easeInOut(duration: 0.8).delay(0.6)) {
            skipOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    BiometricSetupView()
        .environmentObject(AppRouter())
}
