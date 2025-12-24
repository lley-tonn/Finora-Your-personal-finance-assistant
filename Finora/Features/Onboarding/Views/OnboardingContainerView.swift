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
    @State private var skipButtonOpacity: Double = 0
    @State private var autoTransitionTimer: Timer?

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background
            Color.finoraBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top Bar with Skip Button
                HStack {
                    Spacer()

                    if !viewModel.isLastSlide {
                        Button(action: {
                            skipOnboarding()
                        }) {
                            Text("Skip")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.finoraTextSecondary)
                        }
                        .opacity(skipButtonOpacity)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .frame(height: 50)

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
            startAutoTransition()
        }
        .onDisappear {
            stopAutoTransition()
        }
        .onChange(of: viewModel.currentPage) { _ in
            animateCTATransition()
            resetAutoTransition()
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
        // Skip button fades in
        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            skipButtonOpacity = 1.0
        }

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

            // Fade out skip button
            withAnimation(.easeInOut(duration: 0.4)) {
                skipButtonOpacity = 0
            }

            // CTA: Fade + slide up animation (12pt offset, 0.3s delay)
            withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
                ctaOpacity = 1.0
                ctaOffset = 0
            }
        } else {
            // Fade in skip button
            withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
                skipButtonOpacity = 1.0
            }

            // Fade out CTA when leaving final slide
            withAnimation(.easeInOut(duration: 0.4)) {
                ctaOpacity = 0
                ctaOffset = 12
            }
        }
    }

    // MARK: - Auto Transition

    private func startAutoTransition() {
        autoTransitionTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            advanceToNextSlide()
        }
    }

    private func stopAutoTransition() {
        autoTransitionTimer?.invalidate()
        autoTransitionTimer = nil
    }

    private func resetAutoTransition() {
        stopAutoTransition()
        if !viewModel.isLastSlide {
            startAutoTransition()
        }
    }

    private func advanceToNextSlide() {
        guard !viewModel.isLastSlide else {
            stopAutoTransition()
            return
        }

        viewModel.nextSlide()
    }

    // MARK: - Actions

    private func skipOnboarding() {
        stopAutoTransition()
        completeOnboarding()
    }

    private func completeOnboarding() {
        stopAutoTransition()
        // Navigate to authentication
        appRouter.navigate(to: .login)
    }
}

// MARK: - Preview

#Preview {
    OnboardingContainerView()
        .environmentObject(AppRouter())
}
