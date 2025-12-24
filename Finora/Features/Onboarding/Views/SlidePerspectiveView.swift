//
//  SlidePerspectiveView.swift
//  Finora
//
//  Slide 3: Context That Sharpens Judgment
//  Features animated comparison bars with "You" indicator
//

import SwiftUI

struct SlidePerspectiveView: View {

    // MARK: - Animation State

    @State private var barsOffset: CGFloat = 40
    @State private var barsOpacity: Double = 0
    @State private var youGlowOpacity: Double = 0

    // MARK: - Data

    private let comparisonData: [(label: String, value: CGFloat, isYou: Bool)] = [
        ("Top 10%", 0.95, false),
        ("Top 25%", 0.80, false),
        ("You", 0.65, true),
        ("Median", 0.50, false),
        ("Average", 0.40, false)
    ]

    // MARK: - Body

    var body: some View {
        OnboardingPageView(
            headline: "Context That Sharpens Judgment",
            bodyText: "View your habits alongside similar income tiers — anonymized and optional.",
            subtext: "Insight without compromise."
        ) {
            visualContent
        }
        .onAppear {
            animateBars()
        }
    }

    // MARK: - Visual Content

    private var visualContent: some View {
        GeometryReader { geometry in
            ZStack {
                // Subtle background
                LinearGradient(
                    colors: [
                        Color.finoraInfo.opacity(0.06),
                        Color.finoraBackground.opacity(0.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack {
                    Spacer()

                    // Comparison Bars
                    VStack(spacing: 16) {
                        ForEach(Array(comparisonData.enumerated()), id: \.offset) { index, item in
                            comparisonBar(
                                label: item.label,
                                value: item.value,
                                isYou: item.isYou,
                                maxWidth: geometry.size.width * 0.7
                            )
                            .offset(y: barsOffset)
                            .opacity(barsOpacity)
                            .animation(
                                .easeInOut(duration: 0.9).delay(Double(index) * 0.1 + 0.2),
                                value: barsOffset
                            )
                            .animation(
                                .easeInOut(duration: 0.9).delay(Double(index) * 0.1 + 0.2),
                                value: barsOpacity
                            )
                        }
                    }
                    .padding(.horizontal, 40)

                    Spacer()
                }
            }
        }
    }

    // MARK: - Bar Components

    private func comparisonBar(label: String, value: CGFloat, isYou: Bool, maxWidth: CGFloat) -> some View {
        HStack(spacing: 12) {
            // Label
            Text(label)
                .font(.system(size: 15, weight: isYou ? .semibold : .regular))
                .foregroundColor(isYou ? .finoraTextPrimary : .finoraTextSecondary)
                .frame(width: 80, alignment: .leading)

            // Bar
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.finoraBorder.opacity(0.3))
                    .frame(height: 32)

                // Filled portion
                RoundedRectangle(cornerRadius: 8)
                    .fill(isYou ? LinearGradient.finoraAIGradient : LinearGradient(
                        colors: [Color.finoraInfo, Color.finoraInfo.opacity(0.7)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: maxWidth * value, height: 32)

                // "You" glow indicator
                if isYou {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.finoraAIAccent, lineWidth: 2)
                        .frame(width: maxWidth * value, height: 32)
                        .opacity(youGlowOpacity)
                }

                // Value label
                Text("\(Int(value * 100))%")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.leading, 12)
            }
        }
    }

    // MARK: - Animations

    private func animateBars() {
        // Bars slide up + fade in
        withAnimation(.easeInOut(duration: 0.9).delay(0.2)) {
            barsOffset = 0
            barsOpacity = 1.0
        }

        // "You" indicator: soft glow for 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                youGlowOpacity = 0.8
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    youGlowOpacity = 0
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SlidePerspectiveView()
        .background(Color.finoraBackground)
        .preferredColorScheme(.dark)
}
