//
//  ProfileView.swift
//  Finora
//
//  Main profile screen - private control center for user data ownership
//  Security, privacy, and preferences in a calm, professional interface
//

import SwiftUI

struct ProfileView: View {

    // MARK: - Properties

    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject private var appRouter: AppRouter

    @State private var sectionsOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background
            Color.finoraBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Top spacing
                    Spacer()
                        .frame(height: 16)

                    // Profile Header
                    ProfileHeaderView(viewModel: viewModel)
                        .padding(.horizontal, 24)

                    // All Sections
                    VStack(spacing: 28) {
                        ForEach(viewModel.sections) { section in
                            ProfileSectionView(
                                section: section,
                                viewModel: viewModel,
                                onItemTap: { detailType in
                                    appRouter.navigate(to: .profileDetail(detailType))
                                }
                            )
                            .padding(.horizontal, 24)
                        }

                        // Danger Zone
                        ProfileDangerZoneView(viewModel: viewModel)
                            .padding(.horizontal, 24)
                    }
                    .opacity(sectionsOpacity)

                    // Bottom spacing
                    Spacer()
                        .frame(height: 120)
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Sections fade in
        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            sectionsOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    ProfileView()
        .environmentObject(AppRouter())
}
