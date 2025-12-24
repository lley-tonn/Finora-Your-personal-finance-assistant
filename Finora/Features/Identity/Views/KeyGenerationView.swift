//
//  KeyGenerationView.swift
//  Finora
//
//  Premium key generation screen with elegant progress animation
//  Generates decentralized identity keys for user data ownership
//

import SwiftUI

struct KeyGenerationView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter

    @State private var currentState: GenerationState = .ready
    @State private var progressValue: Double = 0.0

    // Animation States
    @State private var iconOpacity: Double = 0
    @State private var iconRotation: Double = 0
    @State private var headlineOpacity: Double = 0
    @State private var headlineOffset: CGFloat = 20
    @State private var bodyOpacity: Double = 0
    @State private var featuresOpacity: Double = 0
    @State private var ctaOpacity: Double = 0
    @State private var ctaOffset: CGFloat = 12

    // MARK: - Generation States

    enum GenerationState {
        case ready
        case generating
        case complete
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.finoraBackground,
                    Color.finoraBackground.opacity(0.95),
                    Color.finoraAIAccent.opacity(0.04)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Icon with state-based display
                ZStack {
                    // Glow effect
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    stateColor.opacity(0.2),
                                    stateColor.opacity(0.0)
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 80
                            )
                        )
                        .frame(width: 160, height: 160)

                    // Progress ring (only during generation)
                    if currentState == .generating {
                        Circle()
                            .trim(from: 0, to: progressValue)
                            .stroke(
                                stateColor,
                                style: StrokeStyle(lineWidth: 3, lineCap: .round)
                            )
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut(duration: 0.3), value: progressValue)
                    }

                    // Icon
                    Image(systemName: stateIcon)
                        .font(.system(size: 72, weight: .light))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [stateColor, stateColor.opacity(0.8)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .rotationEffect(.degrees(iconRotation))
                }
                .opacity(iconOpacity)
                .padding(.bottom, 48)

                // Headline
                Text(stateHeadline)
                    .font(.system(size: 32, weight: .semibold, design: .default))
                    .foregroundColor(.finoraTextPrimary)
                    .multilineTextAlignment(.center)
                    .opacity(headlineOpacity)
                    .offset(y: headlineOffset)
                    .padding(.bottom, 16)

                // Body Text
                Text(stateBody)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .opacity(bodyOpacity)
                    .padding(.bottom, 40)

                // Features (only in ready state)
                if currentState == .ready {
                    keyFeatures
                        .opacity(featuresOpacity)
                }

                Spacer()

                // CTA Button (not shown during generation)
                if currentState != .generating {
                    ctaButton
                        .opacity(ctaOpacity)
                        .offset(y: ctaOffset)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 48)
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Key Features

    private var keyFeatures: some View {
        VStack(spacing: 16) {
            featureRow(
                icon: "lock.shield.fill",
                title: "User-Controlled Encryption",
                description: "Only you hold the keys to your data"
            )

            featureRow(
                icon: "network",
                title: "Decentralized Identity",
                description: "No central authority can access your info"
            )

            featureRow(
                icon: "arrow.triangle.2.circlepath",
                title: "Recoverable & Portable",
                description: "Back up once, access anywhere"
            )
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 32)
    }

    private func featureRow(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.finoraAIAccent)
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

    // MARK: - CTA Button

    private var ctaButton: some View {
        Button(action: {
            handleCTAAction()
        }) {
            HStack(spacing: 8) {
                Image(systemName: ctaIcon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Text(ctaTitle)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    colors: [stateColor, stateColor.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .shadow(
                color: stateColor.opacity(0.3),
                radius: 16,
                x: 0,
                y: 8
            )
        }
    }

    // MARK: - State Properties

    private var stateIcon: String {
        switch currentState {
        case .ready: return "key.fill"
        case .generating: return "key.fill"
        case .complete: return "checkmark.circle.fill"
        }
    }

    private var stateColor: Color {
        switch currentState {
        case .ready: return .finoraAIAccent
        case .generating: return .finoraAIAccent
        case .complete: return .finoraSuccess
        }
    }

    private var stateHeadline: String {
        switch currentState {
        case .ready: return "Create Your Identity"
        case .generating: return "Generating Keys..."
        case .complete: return "Identity Created"
        }
    }

    private var stateBody: String {
        switch currentState {
        case .ready:
            return "We'll generate encryption keys that only you control. These keys secure all your financial data."
        case .generating:
            return "Creating your decentralized identity and encryption keys. This may take a moment."
        case .complete:
            return "Your decentralized identity is ready. Next, we'll back up your recovery phrase."
        }
    }

    private var ctaTitle: String {
        switch currentState {
        case .ready: return "Generate My Keys"
        case .generating: return ""
        case .complete: return "Continue to Backup"
        }
    }

    private var ctaIcon: String {
        switch currentState {
        case .ready: return "sparkles"
        case .generating: return ""
        case .complete: return "arrow.right"
        }
    }

    // MARK: - Actions

    private func handleCTAAction() {
        switch currentState {
        case .ready:
            generateKeys()
        case .generating:
            break
        case .complete:
            navigateToBackup()
        }
    }

    private func generateKeys() {
        // Fade out features
        withAnimation(.easeInOut(duration: 0.4)) {
            featuresOpacity = 0
            ctaOpacity = 0
        }

        // Transition to generating state
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeInOut(duration: 0.6)) {
                currentState = .generating
                headlineOpacity = 1.0
                bodyOpacity = 1.0
            }

            // Start progress animation
            animateProgress()
        }

        // Simulate key generation
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)

            await MainActor.run {
                withAnimation(.easeInOut(duration: 0.6)) {
                    currentState = .complete
                    progressValue = 0.0
                    iconRotation = 0
                }

                // Show CTA again
                withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
                    ctaOpacity = 1.0
                    ctaOffset = 0
                }
            }
        }
    }

    private func animateProgress() {
        // Animate progress from 0 to 1 over 3 seconds
        let steps = 30
        let interval = 0.1

        for step in 0...steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + (interval * Double(step))) {
                progressValue = Double(step) / Double(steps)
            }
        }

        // Rotate icon slightly during generation
        withAnimation(.linear(duration: 3.0)) {
            iconRotation = 360
        }
    }

    private func navigateToBackup() {
        appRouter.navigate(to: .keyBackup)
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Icon with fade
        withAnimation(.easeInOut(duration: 0.8)) {
            iconOpacity = 1.0
        }

        // Headline
        withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
            headlineOpacity = 1.0
            headlineOffset = 0
        }

        // Body
        withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
            bodyOpacity = 1.0
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
    }
}

// MARK: - Preview

#Preview {
    KeyGenerationView()
        .environmentObject(AppRouter())
}
