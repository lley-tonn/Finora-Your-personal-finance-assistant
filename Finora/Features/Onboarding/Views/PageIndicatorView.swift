//
//  PageIndicatorView.swift
//  Finora
//
//  Premium page indicator for onboarding
//  Smooth animations with ease-in-out timing
//

import SwiftUI

struct PageIndicatorView: View {

    // MARK: - Properties

    let numberOfPages: Int
    let currentPage: Int

    private let dotSize: CGFloat = 8
    private let activeDotSize: CGFloat = 24
    private let spacing: CGFloat = 12

    // MARK: - Body

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                dot(for: index)
            }
        }
    }

    // MARK: - Components

    private func dot(for index: Int) -> some View {
        Capsule()
            .fill(index == currentPage ? Color.finoraAIAccent : Color.finoraBorder)
            .frame(
                width: index == currentPage ? activeDotSize : dotSize,
                height: dotSize
            )
            .animation(.easeInOut(duration: 0.6), value: currentPage)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 40) {
        PageIndicatorView(numberOfPages: 3, currentPage: 0)
        PageIndicatorView(numberOfPages: 3, currentPage: 1)
        PageIndicatorView(numberOfPages: 3, currentPage: 2)
    }
    .padding()
    .background(Color.finoraBackground)
    .preferredColorScheme(.dark)
}
