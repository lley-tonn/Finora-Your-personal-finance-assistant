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

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient.finoraPremiumGradient
                .ignoresSafeArea()

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
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating = true
            }

            // Simulate checking authentication and navigate
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                checkAuthenticationStatus()
            }
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
