//
//  ProfileHeaderView.swift
//  Finora
//
//  Profile overview header with user info and security status
//  Clean, professional presentation
//

import SwiftUI

struct ProfileHeaderView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: ProfileViewModel

    @State private var headerOpacity: Double = 0
    @State private var headerOffset: CGFloat = 10

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            // Avatar
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.finoraSecurity,
                                Color.finoraSecurity.opacity(0.7)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)

                Text(viewModel.userInitials)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
            }

            // User Info
            VStack(spacing: 6) {
                Text(viewModel.userName)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                Text(viewModel.userEmail)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
            }

            // Security Badge
            HStack(spacing: 8) {
                Image(systemName: viewModel.securityStatus.icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(viewModel.securityStatus.color)

                Text(viewModel.securityStatus.text)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(viewModel.securityStatus.color)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(viewModel.securityStatus.color.opacity(0.15))
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.finoraSurface)
        )
        .opacity(headerOpacity)
        .offset(y: headerOffset)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.6).delay(0.1)) {
            headerOpacity = 1.0
            headerOffset = 0
        }
    }
}

// MARK: - Preview

#Preview {
    ProfileHeaderView(viewModel: ProfileViewModel())
        .padding()
        .background(Color.finoraBackground)
        .preferredColorScheme(.dark)
}
