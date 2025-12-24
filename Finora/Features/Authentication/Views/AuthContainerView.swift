//
//  AuthContainerView.swift
//  Finora
//
//  Main authentication container with mode toggle and smooth transitions
//  Hosts logo, toggle, form content, and CTA button
//

import SwiftUI

struct AuthContainerView: View {

    // MARK: - Properties

    @StateObject private var viewModel = AuthViewModel()
    @EnvironmentObject private var appRouter: AppRouter

    @State private var logoOpacity: Double = 0
    @State private var logoOffset: CGFloat = -20
    @State private var toggleOpacity: Double = 0
    @State private var ctaOpacity: Double = 0
    @State private var ctaOffset: CGFloat = 12

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.finoraBackground,
                    Color.finoraBackground.opacity(0.95),
                    Color.finoraAIAccent.opacity(0.03)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Logo / Wordmark
                VStack(spacing: 12) {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.system(size: 48, weight: .light))
                        .foregroundStyle(
                            LinearGradient.finoraAIGradient
                        )

                    Text("Finora")
                        .font(.system(size: 36, weight: .semibold, design: .default))
                        .foregroundColor(.finoraTextPrimary)
                }
                .opacity(logoOpacity)
                .offset(y: logoOffset)
                .padding(.bottom, 48)

                // Capsule Toggle
                AuthToggleView(selectedMode: $viewModel.currentMode)
                    .padding(.horizontal, 32)
                    .opacity(toggleOpacity)
                    .padding(.bottom, 40)
                    .onChange(of: viewModel.currentMode) { newMode in
                        viewModel.switchMode(to: newMode)
                    }

                // Content Switcher (with transitions)
                contentSwitcher
                    .frame(height: 380)
                    .padding(.horizontal, 32)

                Spacer()

                // CTA Button
                ctaButton
                    .opacity(ctaOpacity)
                    .offset(y: ctaOffset)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 48)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            animateInitialAppearance()
        }
    }

    // MARK: - Content Switcher

    @ViewBuilder
    private var contentSwitcher: some View {
        ZStack {
            // Login View
            if viewModel.currentMode == .login {
                LoginView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
            }

            // Register View
            if viewModel.currentMode == .register {
                RegisterView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.4), value: viewModel.currentMode)
    }

    // MARK: - CTA Button

    private var ctaButton: some View {
        Button(action: {
            handleCTA()
        }) {
            HStack(spacing: 8) {
                Text(viewModel.currentMode.ctaTitle)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)

                Image(systemName: "arrow.right")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    colors: [
                        Color.finoraAIAccent,
                        Color.finoraAIAccent.opacity(0.8)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .shadow(
                color: Color.finoraAIAccent.opacity(0.3),
                radius: 16,
                x: 0,
                y: 8
            )
        }
        .disabled(!isFormValid)
        .opacity(isFormValid ? 1.0 : 0.5)
    }

    // MARK: - Computed Properties

    private var isFormValid: Bool {
        switch viewModel.currentMode {
        case .login:
            return viewModel.isLoginValid
        case .register:
            return viewModel.isRegisterValid
        }
    }

    // MARK: - Actions

    private func handleCTA() {
        Task {
            do {
                switch viewModel.currentMode {
                case .login:
                    try await viewModel.login()
                case .register:
                    try await viewModel.register()
                }

                // Navigate to next step (e.g., biometric setup or dashboard)
                if viewModel.currentMode == .register {
                    appRouter.navigate(to: .biometricSetup)
                } else {
                    appRouter.navigate(to: .dashboard)
                }
            } catch {
                // TODO: Handle authentication errors
                print("Authentication error: \(error)")
            }
        }
    }

    // MARK: - Animations

    private func animateInitialAppearance() {
        // Logo
        withAnimation(.easeInOut(duration: 0.8)) {
            logoOpacity = 1.0
            logoOffset = 0
        }

        // Toggle
        withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
            toggleOpacity = 1.0
        }

        // CTA Button
        withAnimation(.easeInOut(duration: 0.8).delay(0.4)) {
            ctaOpacity = 1.0
            ctaOffset = 0
        }
    }
}

// MARK: - Preview

#Preview {
    AuthContainerView()
        .environmentObject(AppRouter())
}
