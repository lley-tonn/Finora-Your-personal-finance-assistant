//
//  OnboardingContainerView.swift
//  Finora
//
//  Main onboarding container with TabView, page indicator, and CTA
//  Premium motion design with soft parallax and ease-in-out transitions
//

import SwiftUI

struct OnboardingContainerView: View {

    // MARK: - Properties

    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject private var appRouter: AppRouter

    @State private var ctaOpacity: Double = 0
    @State private var ctaOffset: CGFloat = 12
    @State private var pageIndicatorOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background
            Color.finoraBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Onboarding Slides (TabView)
                TabView(selection: $viewModel.currentPage) {
                    ForEach(viewModel.slides) { slide in
                        slideView(for: slide)
                            .tag(slide.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.6), value: viewModel.currentPage)

                Spacer()
                    .frame(height: 100)
            }

            // Bottom UI (Page Indicator + CTA)
            VStack {
                Spacer()

                // Page Indicator
                PageIndicatorView(
                    numberOfPages: viewModel.slides.count,
                    currentPage: viewModel.currentPage
                )
                .opacity(pageIndicatorOpacity)
                .padding(.bottom, 24)

                // CTA Button (only on final slide)
                if viewModel.isLastSlide {
                    ctaButton
                        .opacity(ctaOpacity)
                        .offset(y: ctaOffset)
                        .padding(.bottom, 48)
                }

                Spacer()
                    .frame(height: viewModel.isLastSlide ? 0 : 72)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            animateInitialAppearance()
        }
        .onChange(of: viewModel.currentPage) { _ in
            animateCTATransition()
        }
    }

    // MARK: - Slide Views

    @ViewBuilder
    private func slideView(for slide: OnboardingSlide) -> some View {
        switch slide.slideType {
        case .intelligentFinance:
            SlideIntelligentFinanceView()
        case .privacy:
            SlidePrivacyView()
        case .perspective:
            SlidePerspectiveView()
        }
    }

    // MARK: - CTA Button

    private var ctaButton: some View {
        Button(action: {
            completeOnboarding()
        }) {
            HStack(spacing: 8) {
                Text("Begin Your Private Experience")
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
                    colors: [Color.finoraAIAccent, Color.finoraAIAccent.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .shadow(color: Color.finoraAIAccent.opacity(0.3), radius: 16, x: 0, y: 8)
        }
        .padding(.horizontal, 32)
    }

    // MARK: - Animations

    private func animateInitialAppearance() {
        // Page indicator fades in
        withAnimation(.easeInOut(duration: 0.8).delay(1.2)) {
            pageIndicatorOpacity = 1.0
        }
    }

    private func animateCTATransition() {
        if viewModel.isLastSlide {
            // Reset state first
            ctaOpacity = 0
            ctaOffset = 12

            // CTA: Fade + slide up animation (12pt offset, 0.3s delay)
            withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
                ctaOpacity = 1.0
                ctaOffset = 0
            }
        } else {
            // Fade out CTA when leaving final slide
            withAnimation(.easeInOut(duration: 0.4)) {
                ctaOpacity = 0
                ctaOffset = 12
            }
        }
    }

    // MARK: - Actions

    private func completeOnboarding() {
        // Navigate to authentication
        appRouter.navigate(to: .login)
    }
}

// MARK: - Preview

#Preview {
    OnboardingContainerView()
        .environmentObject(AppRouter())
}
