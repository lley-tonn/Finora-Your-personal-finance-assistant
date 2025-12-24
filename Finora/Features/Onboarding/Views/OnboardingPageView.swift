//
//  OnboardingPageView.swift
//  Finora
//
//  Reusable layout component for onboarding slides
//  Premium spacing and typography
//

import SwiftUI

struct OnboardingPageView<Content: View>: View {

    // MARK: - Properties

    let headline: String
    let bodyText: String
    let subtext: String?
    let visualContent: Content

    @State private var headlineOpacity: Double = 0
    @State private var headlineOffset: CGFloat = 12
    @State private var bodyOpacity: Double = 0
    @State private var subtextOpacity: Double = 0

    // MARK: - Initialization

    init(
        headline: String,
        bodyText: String,
        subtext: String? = nil,
        @ViewBuilder visualContent: () -> Content
    ) {
        self.headline = headline
        self.bodyText = bodyText
        self.subtext = subtext
        self.visualContent = visualContent()
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top 60% - Visual Content
                visualContent
                    .frame(height: geometry.size.height * 0.6)

                // Middle - Headline
                Text(headline)
                    .font(.system(size: 32, weight: .semibold, design: .default))
                    .foregroundColor(.finoraTextPrimary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                    .opacity(headlineOpacity)
                    .offset(y: headlineOffset)

                // Below - Body Text
                Text(bodyText)
                    .font(.system(size: 17, weight: .regular, design: .default))
                    .foregroundColor(.finoraTextSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    .opacity(bodyOpacity)

                // Bottom - Subtext (optional)
                if let subtext = subtext {
                    Text(subtext)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.finoraTextTertiary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 16)
                        .opacity(subtextOpacity)
                }

                Spacer()
            }
        }
        .onAppear {
            animateTextAppearance()
        }
    }

    // MARK: - Animations

    private func animateTextAppearance() {
        // Headline: Fade + slight vertical offset
        withAnimation(.easeInOut(duration: 0.8)) {
            headlineOpacity = 1
            headlineOffset = 0
        }

        // Body: Fade only
        withAnimation(.easeInOut(duration: 0.8).delay(0.1)) {
            bodyOpacity = 1
        }

        // Subtext: Delayed fade
        if subtext != nil {
            withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
                subtextOpacity = 1
            }
        }
    }
}

// MARK: - Preview

#Preview {
    OnboardingPageView(
        headline: "Finance, Elevated by Intelligence",
        bodyText: "Finora observes your financial patterns and transforms them into precise, thoughtful guidance.",
        subtext: "Quietly working in the background, always in your favor."
    ) {
        Rectangle()
            .fill(Color.finoraAIAccent.opacity(0.1))
    }
    .background(Color.finoraBackground)
    .preferredColorScheme(.dark)
}
