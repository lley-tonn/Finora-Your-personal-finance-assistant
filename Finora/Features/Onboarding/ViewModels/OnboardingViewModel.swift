//
//  OnboardingViewModel.swift
//  Finora
//
//  Manages onboarding state and navigation
//

import SwiftUI

@MainActor
class OnboardingViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var currentPage: Int = 0
    @Published var slides: [OnboardingSlide] = OnboardingSlide.slides

    // MARK: - Computed Properties

    var isLastSlide: Bool {
        currentPage == slides.count - 1
    }

    var canGoNext: Bool {
        currentPage < slides.count - 1
    }

    var canGoPrevious: Bool {
        currentPage > 0
    }

    // MARK: - Methods

    func nextSlide() {
        guard canGoNext else { return }
        withAnimation(.easeInOut(duration: 0.6)) {
            currentPage += 1
        }
    }

    func previousSlide() {
        guard canGoPrevious else { return }
        withAnimation(.easeInOut(duration: 0.6)) {
            currentPage -= 1
        }
    }

    func goToSlide(_ index: Int) {
        guard index >= 0 && index < slides.count else { return }
        withAnimation(.easeInOut(duration: 0.6)) {
            currentPage = index
        }
    }

    func completeOnboarding() {
        // TODO: Navigate to next screen
        print("Onboarding completed")
    }
}
