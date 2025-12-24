//
//  ProfileDangerZoneView.swift
//  Finora
//
//  Account actions section - sign out and delete account
//  Calm design with clear separation from other settings
//

import SwiftUI

struct ProfileDangerZoneView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: ProfileViewModel

    @State private var dangerZoneOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section Title
            Text("Account Actions")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.finoraTextSecondary)
                .textCase(.uppercase)
                .padding(.horizontal, 4)

            // Actions
            VStack(spacing: 8) {
                // Sign Out
                Button(action: {
                    viewModel.signOut()
                }) {
                    HStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(Color.finoraTextSecondary.opacity(0.15))
                                .frame(width: 44, height: 44)

                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.finoraTextSecondary)
                        }

                        Text("Sign Out")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.finoraTextPrimary)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.finoraTextTertiary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color.finoraSurface)
                    .cornerRadius(14)
                    .contentShape(Rectangle())
                }
                .buttonStyle(ProfileRowButtonStyle())

                // Delete Account
                Button(action: {
                    viewModel.deleteAccount()
                }) {
                    HStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(Color.finoraExpense.opacity(0.15))
                                .frame(width: 44, height: 44)

                            Image(systemName: "trash.fill")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.finoraExpense)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Delete Account")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.finoraExpense)

                            Text("Permanently remove all data")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.finoraTextSecondary)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.finoraTextTertiary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color.finoraSurface)
                    .cornerRadius(14)
                    .contentShape(Rectangle())
                }
                .buttonStyle(ProfileRowButtonStyle())
            }
        }
        .opacity(dangerZoneOpacity)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.6).delay(0.8)) {
            dangerZoneOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    ProfileDangerZoneView(viewModel: ProfileViewModel())
        .padding()
        .background(Color.finoraBackground)
        .preferredColorScheme(.dark)
}
