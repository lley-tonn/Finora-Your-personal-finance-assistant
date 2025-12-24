//
//  SplashView.swift
//  Finora
//
//  Initial splash screen shown on app launch
//  Displays brand identity and checks user authentication status
//

import SwiftUI

struct SplashView: View {

    // MARK: - Environment

    @EnvironmentObject private var router: AppRouter

    // MARK: - State

    @State private var isAnimating = false
    @State private var showDevMenu = false

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient.finoraPremiumGradient
                .ignoresSafeArea()

            if showDevMenu {
                // Development Quick Access Menu
                devMenu
            } else {
                VStack(spacing: 24) {
                    Spacer()

                    // App Icon/Logo
                    ZStack {
                        Circle()
                            .fill(Color.finoraAIAccent.opacity(0.2))
                            .frame(width: 120, height: 120)
                            .scaleEffect(isAnimating ? 1.2 : 1.0)

                        Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                    }
                    .onTapGesture(count: 3) {
                        showDevMenu = true
                    }

                    // App Name
                    Text("Finora")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)

                    // Tagline
                    Text("AI-Powered Finance, Your Data Privacy")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))

                    Spacer()

                    // Loading indicator
                    ProgressView()
                        .tint(.white)
                        .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating = true
            }

            // Simulate checking authentication and navigate
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if !showDevMenu {
                    checkAuthenticationStatus()
                }
            }
        }
    }

    // MARK: - Dev Menu

    private var devMenu: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("🔧 Development Menu")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 60)
                    .padding(.bottom, 20)

                Group {
                    devButton("📱 Main Tab View (Dashboard)", route: .mainTab)
                    devButton("🚀 Onboarding", route: .onboarding)
                    devButton("🔐 Authentication", route: .login)
                    devButton("👤 Biometric Setup", route: .biometricSetup)
                    devButton("🔑 Key Generation", route: .keyGeneration)
                    devButton("📝 Key Backup", route: .keyBackup)
                    devButton("📊 Dashboard Only", route: .dashboard)
                    devButton("💰 Budget Overview", route: .budgetOverview)
                }

                Button(action: {
                    showDevMenu = false
                    checkAuthenticationStatus()
                }) {
                    Text("Continue Normal Flow")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 20)
                }
            }
            .padding(.horizontal, 24)
        }
    }

    private func devButton(_ title: String, route: AppRoute) -> some View {
        Button(action: {
            router.navigate(to: route)
        }) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(Color.white.opacity(0.15))
                .cornerRadius(12)
        }
    }

    // MARK: - Methods

    private func checkAuthenticationStatus() {
        // TODO: Check if user is authenticated
        // For now, navigate to onboarding
        router.navigate(to: .onboarding)
    }
}

// MARK: - Preview

#Preview {
    SplashView()
        .environmentObject(AppRouter())
}
