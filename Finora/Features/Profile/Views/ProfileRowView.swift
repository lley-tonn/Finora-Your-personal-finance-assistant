//
//  ProfileRowView.swift
//  Finora
//
//  Reusable row component for profile items
//  Supports detail navigation and toggle switches
//

import SwiftUI

struct ProfileRowView: View {

    // MARK: - Properties

    let item: ProfileItem
    @ObservedObject var viewModel: ProfileViewModel
    let onTap: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: {
            handleAction()
        }) {
            HStack(spacing: 14) {
                // Icon
                ZStack {
                    Circle()
                        .fill(item.color.opacity(0.15))
                        .frame(width: 44, height: 44)

                    Image(systemName: item.icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(item.color)
                }

                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(item.isDestructive ? .finoraExpense : .finoraTextPrimary)

                    Text(item.subtitle)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.finoraTextSecondary)
                }

                Spacer()

                // Trailing Element
                trailingElement
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.finoraSurface)
            .cornerRadius(14)
            .contentShape(Rectangle())
        }
        .buttonStyle(ProfileRowButtonStyle())
    }

    // MARK: - Trailing Element

    @ViewBuilder
    private var trailingElement: some View {
        switch item.action {
        case .detail:
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.finoraTextTertiary)

        case .toggle(let type, _):
            Toggle("", isOn: binding(for: type))
                .labelsHidden()
                .tint(.finoraAIAccent)
        }
    }

    // MARK: - Helper Methods

    private func binding(for type: ProfileToggleType) -> Binding<Bool> {
        Binding(
            get: { viewModel.getToggleState(type) },
            set: { _ in viewModel.toggle(type) }
        )
    }

    private func handleAction() {
        switch item.action {
        case .detail:
            onTap()
        case .toggle:
            break // Toggle handles itself
        }
    }
}

// MARK: - Button Style

struct ProfileRowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 12) {
        ProfileRowView(
            item: ProfileItem(
                icon: "key.fill",
                title: "Private Key Status",
                subtitle: "Your encryption keys are secure",
                color: .finoraSecurity,
                action: .detail(.keyStatus)
            ),
            viewModel: ProfileViewModel(),
            onTap: {}
        )

        ProfileRowView(
            item: ProfileItem(
                icon: "sparkles",
                title: "AI Insights",
                subtitle: "Enabled",
                color: .finoraAIAccent,
                action: .toggle(.aiInsights, true)
            ),
            viewModel: ProfileViewModel(),
            onTap: {}
        )
    }
    .padding()
    .background(Color.finoraBackground)
    .preferredColorScheme(.dark)
}
