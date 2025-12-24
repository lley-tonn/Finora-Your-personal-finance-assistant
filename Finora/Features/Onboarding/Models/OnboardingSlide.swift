//
//  OnboardingSlide.swift
//  Finora
//
//  Data model for onboarding slides
//

import Foundation

struct OnboardingSlide: Identifiable, Equatable {
    let id: Int
    let headline: String
    let body: String
    let subtext: String?
    let slideType: SlideType

    enum SlideType: Equatable {
        case intelligentFinance
        case privacy
        case perspective
    }
}

// MARK: - Sample Data

extension OnboardingSlide {
    static let slides: [OnboardingSlide] = [
        OnboardingSlide(
            id: 0,
            headline: "Finance, Elevated by Intelligence",
            body: "Finora observes your financial patterns and transforms them into precise, thoughtful guidance.",
            subtext: "Quietly working in the background, always in your favor.",
            slideType: .intelligentFinance
        ),
        OnboardingSlide(
            id: 1,
            headline: "Your Wealth. Your Data. Your Authority.",
            body: "Your information is encrypted and secured through decentralized storage.",
            subtext: "Designed for discretion. Engineered for trust.",
            slideType: .privacy
        ),
        OnboardingSlide(
            id: 2,
            headline: "Context That Sharpens Judgment",
            body: "View your habits alongside similar income tiers — anonymized and optional.",
            subtext: "Insight without compromise.",
            slideType: .perspective
        )
    ]
}
