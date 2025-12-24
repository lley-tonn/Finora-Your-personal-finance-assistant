//
//  KeyBackupView.swift
//  Finora
//
//  Premium recovery phrase backup screen with security warnings
//  Critical for account recovery and data sovereignty
//

import SwiftUI

struct KeyBackupView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter

    @State private var recoveryPhrase = [
        "ocean", "mountain", "forest", "river", "sunset", "valley",
        "meadow", "glacier", "canyon", "desert", "prairie", "lagoon"
    ]
    @State private var hasConfirmed = false

    // Animation States
    @State private var warningOpacity: Double = 0
    @State private var warningScale: CGFloat = 0.95
    @State private var phraseOpacity: Double = 0
    @State private var confirmationOpacity: Double = 0
    @State private var ctaOpacity: Double = 0
    @State private var ctaOffset: CGFloat = 12

    // MARK: - Body

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.finoraBackground,
                    Color.finoraBackground.opacity(0.95),
                    Color.finoraWarning.opacity(0.03)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Top spacing
                    Spacer()
                        .frame(height: 40)

                    // Critical Warning Banner
                    warningBanner
                        .opacity(warningOpacity)
                        .scaleEffect(warningScale)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 40)

                    // Headline
                    Text("Your Recovery Phrase")
                        .font(.system(size: 28, weight: .semibold, design: .default))
                        .foregroundColor(.finoraTextPrimary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 12)

                    // Subheadline
                    Text("Write these 12 words down in order. Store them safely offline.")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.finoraTextSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 32)

                    // Recovery Phrase Grid
                    recoveryPhraseGrid
                        .opacity(phraseOpacity)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 32)

                    // Security Tips
                    securityTips
                        .opacity(phraseOpacity)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 32)

                    // Confirmation Toggle
                    confirmationToggle
                        .opacity(confirmationOpacity)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 24)

                    // CTA Button
                    ctaButton
                        .opacity(ctaOpacity)
                        .offset(y: ctaOffset)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 48)
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Warning Banner

    private var warningBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.finoraWarning)

            VStack(alignment: .leading, spacing: 4) {
                Text("Critical Security Step")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.finoraTextPrimary)

                Text("Never share this phrase. We cannot recover it if lost.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
            }

            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.finoraWarning.opacity(0.12))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.finoraWarning.opacity(0.3), lineWidth: 1)
        )
    }

    // MARK: - Recovery Phrase Grid

    private var recoveryPhraseGrid: some View {
        VStack(spacing: 12) {
            ForEach(Array(recoveryPhrase.enumerated()), id: \.offset) { index, word in
                phraseRow(number: index + 1, word: word)
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .leading)),
                        removal: .opacity
                    ))
            }
        }
    }

    private func phraseRow(number: Int, word: String) -> some View {
        HStack(spacing: 16) {
            // Number
            Text("\(number)")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraTextTertiary)
                .frame(width: 24, alignment: .trailing)

            // Word
            Text(word)
                .font(.system(size: 17, weight: .semibold, design: .monospaced))
                .foregroundColor(.finoraTextPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Copy indicator (visual only, no functionality)
            Image(systemName: "doc.on.doc")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.finoraTextTertiary.opacity(0.5))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.finoraSurface)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.finoraBorder.opacity(0.2), lineWidth: 1)
        )
    }

    // MARK: - Security Tips

    private var securityTips: some View {
        VStack(spacing: 12) {
            tipRow(icon: "hand.raised.fill", text: "Never share with anyone, including Finora support")
            tipRow(icon: "icloud.slash.fill", text: "Don't store digitally or take screenshots")
            tipRow(icon: "pencil.and.list.clipboard", text: "Write on paper and store in a safe place")
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.finoraSurface.opacity(0.5))
        )
    }

    private func tipRow(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraAIAccent)
                .frame(width: 16)

            Text(text)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.finoraTextSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - Confirmation Toggle

    private var confirmationToggle: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                hasConfirmed.toggle()
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: hasConfirmed ? "checkmark.square.fill" : "square")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(hasConfirmed ? .finoraSuccess : .finoraBorder)

                Text("I have written down my recovery phrase")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.finoraTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.finoraSurface)
                )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(
                        hasConfirmed ? Color.finoraSuccess.opacity(0.4) : Color.finoraBorder.opacity(0.2),
                        lineWidth: 1.5
                    )
            )
        }
    }

    // MARK: - CTA Button

    private var ctaButton: some View {
        Button(action: {
            completeBackup()
        }) {
            HStack(spacing: 8) {
                Image(systemName: "checkmark.shield.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Text("I've Secured My Phrase")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    colors: [
                        hasConfirmed ? Color.finoraSuccess : Color.finoraBorder,
                        hasConfirmed ? Color.finoraSuccess.opacity(0.8) : Color.finoraBorder.opacity(0.8)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .shadow(
                color: hasConfirmed ? Color.finoraSuccess.opacity(0.3) : Color.clear,
                radius: 16,
                x: 0,
                y: 8
            )
        }
        .disabled(!hasConfirmed)
        .opacity(hasConfirmed ? 1.0 : 0.6)
    }

    // MARK: - Actions

    private func completeBackup() {
        // TODO: Implement actual backup verification
        // Navigate to dashboard
        appRouter.navigate(to: .dashboard)
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Warning banner
        withAnimation(.easeInOut(duration: 0.6)) {
            warningOpacity = 1.0
            warningScale = 1.0
        }

        // Recovery phrase - staggered appearance
        for (index, _) in recoveryPhrase.enumerated() {
            withAnimation(.easeInOut(duration: 0.4).delay(0.3 + Double(index) * 0.05)) {
                phraseOpacity = 1.0
            }
        }

        // Confirmation toggle
        withAnimation(.easeInOut(duration: 0.6).delay(1.0)) {
            confirmationOpacity = 1.0
        }

        // CTA Button
        withAnimation(.easeInOut(duration: 0.6).delay(1.2)) {
            ctaOpacity = 1.0
            ctaOffset = 0
        }
    }
}

// MARK: - Preview

#Preview {
    KeyBackupView()
        .environmentObject(AppRouter())
}
