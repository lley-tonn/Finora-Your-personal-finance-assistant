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
    @State private var hasAppeared: Bool = false

    // Haptic feedback generator
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)

    // MARK: - Body

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases) { tab in
                tabButton(for: tab)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(Color.white.opacity(0.1), lineWidth: 0.5)
        )
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 10)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
        .background(Color.clear)
        .scaleEffect(hasAppeared ? 1.0 : 0.88)
        .offset(y: hasAppeared ? 0 : 20)
        .opacity(hasAppeared ? 1.0 : 0.0)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.68, blendDuration: 0)) {
                hasAppeared = true
            }
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
                    .scaleEffect(isSelected(tab) ? 1.08 : 1.0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.65), value: isSelected(tab))

                // Label
                Text(tab.label)
                    .font(.system(size: 11, weight: isSelected(tab) ? .semibold : .regular))
                    .foregroundColor(isSelected(tab) ? .finoraAIAccent : .finoraTextTertiary)
                    .animation(.easeInOut(duration: 0.25), value: isSelected(tab))

                // Active indicator dot
                Circle()
                    .fill(Color.finoraAIAccent)
                    .frame(width: 4, height: 4)
                    .opacity(isSelected(tab) ? 1.0 : 0.0)
                    .scaleEffect(isSelected(tab) ? 1.0 : 0.5)
                    .animation(.spring(response: 0.35, dampingFraction: 0.6), value: isSelected(tab))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .contentShape(Rectangle())
            .scaleEffect(isSelected(tab) ? 1.0 : 0.96)
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isSelected(tab))
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
