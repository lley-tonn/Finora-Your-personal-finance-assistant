//
//  SlideIntelligentFinanceView.swift
//  Finora
//
//  Slide 1: Finance, Elevated by Intelligence
//  Features animated graph lines and data points
//

import SwiftUI

struct SlideIntelligentFinanceView: View {

    // MARK: - Animation State

    @State private var lineProgress: CGFloat = 0
    @State private var dataPointsOpacity: Double = 0

    // MARK: - Data

    private let dataPoints: [(x: CGFloat, y: CGFloat)] = [
        (0.15, 0.7),
        (0.30, 0.5),
        (0.45, 0.6),
        (0.60, 0.4),
        (0.75, 0.3),
        (0.90, 0.2)
    ]

    // MARK: - Body

    var body: some View {
        OnboardingPageView(
            headline: "Finance, Elevated by Intelligence",
            bodyText: "Finora observes your financial patterns and transforms them into precise, thoughtful guidance.",
            subtext: "Quietly working in the background, always in your favor."
        ) {
            visualContent
        }
        .onAppear {
            animateGraph()
        }
    }

    // MARK: - Visual Content

    private var visualContent: some View {
        GeometryReader { geometry in
            ZStack {
                // Subtle background gradient
                LinearGradient(
                    colors: [
                        Color.finoraAIAccent.opacity(0.08),
                        Color.finoraBackground.opacity(0.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack {
                    Spacer()

                    // Graph Container
                    ZStack {
                        // Grid lines (subtle)
                        gridLines

                        // Animated graph line
                        graphLine(in: geometry.size)
                            .trim(from: 0, to: lineProgress)
                            .stroke(
                                LinearGradient.finoraAIGradient,
                                style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                            )

                        // Data points (staggered fade-in)
                        dataPointsView(in: geometry.size)
                    }
                    .frame(height: geometry.size.height * 0.5)
                    .padding(.horizontal, 40)

                    Spacer()
                }
            }
        }
    }

    // MARK: - Graph Components

    private var gridLines: some View {
        VStack(spacing: 0) {
            ForEach(0..<4, id: \.self) { _ in
                Divider()
                    .background(Color.finoraBorder.opacity(0.3))
                Spacer()
            }
        }
    }

    private func graphLine(in size: CGSize) -> Path {
        Path { path in
            guard !dataPoints.isEmpty else { return }

            let width = size.width
            let height = size.height

            let firstPoint = dataPoints[0]
            path.move(to: CGPoint(
                x: firstPoint.x * width,
                y: firstPoint.y * height
            ))

            for point in dataPoints.dropFirst() {
                path.addLine(to: CGPoint(
                    x: point.x * width,
                    y: point.y * height
                ))
            }
        }
    }

    private func dataPointsView(in size: CGSize) -> some View {
        ForEach(Array(dataPoints.enumerated()), id: \.offset) { index, point in
            Circle()
                .fill(Color.finoraAIAccent)
                .frame(width: 8, height: 8)
                .overlay(
                    Circle()
                        .stroke(Color.finoraBackground, lineWidth: 2)
                )
                .position(
                    x: point.x * size.width,
                    y: point.y * size.height
                )
                .opacity(dataPointsOpacity)
                .animation(
                    .easeInOut(duration: 0.6).delay(Double(index) * 0.1 + 1.4),
                    value: dataPointsOpacity
                )
        }
    }

    // MARK: - Animations

    private func animateGraph() {
        // Graph line animation: 1.2s duration, 0.2s delay
        withAnimation(.easeInOut(duration: 1.2).delay(0.2)) {
            lineProgress = 1.0
        }

        // Data points: staggered fade-in after line completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            dataPointsOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    SlideIntelligentFinanceView()
        .background(Color.finoraBackground)
        .preferredColorScheme(.dark)
}
