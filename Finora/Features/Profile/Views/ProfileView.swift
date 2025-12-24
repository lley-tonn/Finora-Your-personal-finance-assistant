//
//  ProfileView.swift
//  Finora
//
//  User profile and settings screen
//  Account management, security controls, and preferences
//

import SwiftUI

struct ProfileView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 60)

                // Icon
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 64, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.finoraSecurity, Color.finoraSecurity.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(.bottom, 24)

                // Title
                Text("Profile & Settings")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                // Description
                Text("Manage your account, security, and preferences")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)

                Spacer()
            }
        }
        .background(Color.finoraBackground)
    }
}

// MARK: - Preview

#Preview {
    ProfileView()
        .environmentObject(AppRouter())
        .preferredColorScheme(.dark)
}
