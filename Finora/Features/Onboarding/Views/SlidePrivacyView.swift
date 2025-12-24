//
//  SlidePrivacyView.swift
//  Finora
//
//  Slide 2: Your Wealth. Your Data. Your Authority.
//  Features lock/vault geometry with pulse animation
//

import SwiftUI

struct SlidePrivacyView: View {

    // MARK: - Animation State

    @State private var nodesOpacity: Double = 0
    @State private var outlineProgress: CGFloat = 0
    @State private var pulseOpacity: Double = 0.85

    // MARK: - Body

    var body: some View {
        OnboardingPageView(
            headline: "Your Wealth. Your Data. Your Authority.",
            bodyText: "Your information is encrypted and secured through decentralized storage.",
            subtext: "Designed for discretion. Engineered for trust."
        ) {
            visualContent
        }
        .onAppear {
            animateLock()
            startPulse()
        }
    }

    // MARK: - Visual Content

    private var visualContent: some View {
        GeometryReader { geometry in
            ZStack {
                // Subtle background
                LinearGradient(
                    colors: [
                        Color.finoraSecurity.opacity(0.06),
                        Color.finoraBackground.opacity(0.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack {
                    Spacer()

                    // Lock/Vault Geometry
                    ZStack {
                        // Connection nodes
                        lockNodes
                            .opacity(nodesOpacity)

                        // Vault outline (hexagon)
                        vaultOutline
                            .trim(from: 0, to: outlineProgress)
                            .stroke(
                                Color.finoraSecurity,
                                style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
                            )

                        // Central lock icon
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 48, weight: .light))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.finoraSecurity, Color.finoraAIAccent],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .opacity(nodesOpacity)
                            .opacity(pulseOpacity)
                    }
                    .frame(width: 200, height: 200)

                    Spacer()
                }
            }
        }
    }

    // MARK: - Lock Components

    private var lockNodes: some View {
        ForEach(0..<6, id: \.self) { index in
            Circle()
                .fill(Color.finoraSecurity.opacity(0.6))
                .frame(width: 6, height: 6)
                .offset(nodeOffset(for: index, radius: 100))
                .overlay(
                    Circle()
                        .stroke(Color.finoraSecurity, lineWidth: 1)
                        .frame(width: 12, height: 12)
                        .offset(nodeOffset(for: index, radius: 100))
                        .opacity(0.4)
                )
        }
    }

    private var vaultOutline: Path {
        Path { path in
            let center = CGPoint(x: 100, y: 100)
            let radius: CGFloat = 100
            let angleOffset = -CGFloat.pi / 2 // Start from top

            for i in 0..<6 {
                let angle = angleOffset + (CGFloat(i) * CGFloat.pi / 3)
                let point = CGPoint(
                    x: center.x + radius * cos(angle),
                    y: center.y + radius * sin(angle)
                )

                if i == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.closeSubpath()
        }
    }

    // MARK: - Helper Methods

    private func nodeOffset(for index: Int, radius: CGFloat) -> CGSize {
        let angle = -CGFloat.pi / 2 + (CGFloat(index) * CGFloat.pi / 3)
        return CGSize(
            width: radius * cos(angle),
            height: radius * sin(angle)
        )
    }

    // MARK: - Animations

    private func animateLock() {
        // Nodes fade in first
        withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
            nodesOpacity = 1.0
        }

        // Outline draws after nodes
        withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
            outlineProgress = 1.0
        }
    }

    private func startPulse() {
        // Slow, deliberate pulse every 6-8 seconds
        Timer.scheduledTimer(withTimeInterval: 7.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 2.0)) {
                pulseOpacity = 1.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 2.0)) {
                    pulseOpacity = 0.85
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SlidePrivacyView()
        .background(Color.finoraBackground)
        .preferredColorScheme(.dark)
}
