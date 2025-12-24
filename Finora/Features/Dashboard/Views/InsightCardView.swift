//
//  InsightCardView.swift
//  Finora
//
//  Displays AI-powered financial insights on dashboard
//

import SwiftUI

struct InsightCardView: View {

    @EnvironmentObject private var router: AppRouter

    var body: some View {
        Button(action: { router.navigate(to: .aiChat) }) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(LinearGradient.finoraAIGradient)
                        .frame(width: 48, height: 48)

                    Image(systemName: "sparkles")
                        .foregroundColor(.white)
                        .font(.title3.weight(.semibold))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("AI Insight")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.finoraAIAccent)

                    Text("You're on track to save $1,200 this month")
                        .font(.subheadline)
                        .foregroundColor(.finoraTextPrimary)

                    Text("Tap to learn more")
                        .font(.caption)
                        .foregroundColor(.finoraTextSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.finoraTextTertiary)
            }
            .padding(16)
            .background(Color.finoraAIInsightBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.finoraAIAccent.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

#Preview {
    InsightCardView()
        .environmentObject(AppRouter())
        .padding()
        .background(Color.finoraBackground)
}
