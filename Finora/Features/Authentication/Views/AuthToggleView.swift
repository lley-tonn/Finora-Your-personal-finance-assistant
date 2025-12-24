//
//  AuthToggleView.swift
//  Finora
//
//  Capsule toggle for switching between Login and Register modes
//  Premium animation with sliding indicator and smooth transitions
//

import SwiftUI

struct AuthToggleView: View {

    // MARK: - Properties

    @Binding var selectedMode: AuthMode

    // MARK: - Body

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AuthMode.allCases, id: \.self) { mode in
                toggleSegment(for: mode)
            }
        }
        .frame(height: 48)
        .background(
            Capsule()
                .fill(Color.finoraBorder.opacity(0.3))
        )
        .overlay(
            // Sliding selection indicator
            GeometryReader { geometry in
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.finoraAIAccent,
                                Color.finoraAIAccent.opacity(0.8)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geometry.size.width / 2)
                    .offset(x: selectedMode == .login ? 0 : geometry.size.width / 2)
                    .shadow(
                        color: Color.finoraAIAccent.opacity(0.3),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
                    .animation(.easeInOut(duration: 0.35), value: selectedMode)
            }
        )
    }

    // MARK: - Components

    private func toggleSegment(for mode: AuthMode) -> some View {
        Button(action: {
            selectedMode = mode
        }) {
            Text(mode.rawValue)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(
                    selectedMode == mode
                        ? .white
                        : .finoraTextSecondary
                )
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .contentShape(Rectangle())
        }
        .animation(.easeInOut(duration: 0.35), value: selectedMode)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 32) {
        AuthToggleView(selectedMode: .constant(.login))
        AuthToggleView(selectedMode: .constant(.register))
    }
    .padding(.horizontal, 32)
    .background(Color.finoraBackground)
    .preferredColorScheme(.dark)
}
