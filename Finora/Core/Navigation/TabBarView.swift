//
//  TabBarView.swift
//  Finora
//
//  Custom bottom tab bar with premium design and haptic feedback
//  Calm, trustworthy navigation with smooth transitions
//

import SwiftUI

struct TabBarView: View {

    // MARK: - Properties

    @Binding var selectedTab: TabItem
    @State private var indicatorOffset: CGFloat = 0

    // Haptic feedback generator
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            // Top divider
            Rectangle()
                .fill(Color.finoraBorder.opacity(0.15))
                .frame(height: 0.5)

            HStack(spacing: 0) {
                ForEach(TabItem.allCases) { tab in
                    tabButton(for: tab)
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)
            .padding(.bottom, 4)
        }
        .background(
            .ultraThinMaterial,
            in: Rectangle()
        )
        .overlay(alignment: .bottom) {
            // Safe area spacer for home indicator
            Color.clear
                .frame(height: 0)
                .background(Color.finoraBackground.opacity(0.95))
        }
    }

    // MARK: - Tab Button

    private func tabButton(for tab: TabItem) -> some View {
        Button(action: {
            selectTab(tab)
        }) {
            VStack(spacing: 4) {
                // Icon
                Image(systemName: tab.iconName)
                    .font(.system(size: 22, weight: isSelected(tab) ? .semibold : .regular))
                    .foregroundColor(isSelected(tab) ? .finoraAIAccent : .finoraTextTertiary)
                    .frame(height: 28)

                // Label
                Text(tab.label)
                    .font(.system(size: 11, weight: isSelected(tab) ? .semibold : .regular))
                    .foregroundColor(isSelected(tab) ? .finoraAIAccent : .finoraTextTertiary)

                // Active indicator dot
                Circle()
                    .fill(Color.finoraAIAccent)
                    .frame(width: 4, height: 4)
                    .opacity(isSelected(tab) ? 1.0 : 0.0)
                    .scaleEffect(isSelected(tab) ? 1.0 : 0.5)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .contentShape(Rectangle())
        }
        .buttonStyle(TabButtonStyle())
        .accessibilityLabel(tab.accessibilityLabel)
        .accessibilityAddTraits(isSelected(tab) ? .isSelected : [])
    }

    // MARK: - Helpers

    private func isSelected(_ tab: TabItem) -> Bool {
        selectedTab == tab
    }

    private func selectTab(_ tab: TabItem) {
        guard selectedTab != tab else { return }

        // Trigger haptic feedback
        impactFeedback.impactOccurred()

        // Animate tab change
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedTab = tab
        }
    }
}

// MARK: - Tab Button Style

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        Spacer()

        TabBarView(selectedTab: .constant(.home))
    }
    .background(Color.finoraBackground)
    .preferredColorScheme(.dark)
}
