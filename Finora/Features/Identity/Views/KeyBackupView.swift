//
//  KeyBackupView.swift
//  Finora
//
//  Displays recovery phrase for backing up encryption keys
//  Critical for account recovery
//

import SwiftUI

struct KeyBackupView: View {

    @EnvironmentObject private var router: AppRouter
    @State private var recoveryPhrase = [
        "ocean", "mountain", "forest", "river", "sunset", "valley",
        "meadow", "glacier", "canyon", "desert", "prairie", "lagoon"
    ]
    @State private var hasConfirmed = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Warning
                HStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.finoraWarning)

                    Text("Write down these words in order. Store them safely. Never share them.")
                        .font(.subheadline)
                        .foregroundColor(.finoraTextPrimary)
                }
                .padding()
                .background(Color.finoraWarning.opacity(0.1))
                .cornerRadius(12)

                // Recovery Phrase
                VStack(spacing: 12) {
                    ForEach(Array(recoveryPhrase.enumerated()), id: \.offset) { index, word in
                        HStack {
                            Text("\(index + 1).")
                                .frame(width: 30, alignment: .leading)
                                .foregroundColor(.finoraTextTertiary)

                            Text(word)
                                .fontWeight(.medium)
                                .foregroundColor(.finoraTextPrimary)

                            Spacer()
                        }
                        .padding()
                        .background(Color.finoraSurface)
                        .cornerRadius(8)
                    }
                }

                // Confirmation
                Toggle(isOn: $hasConfirmed) {
                    Text("I have written down my recovery phrase")
                        .font(.subheadline)
                        .foregroundColor(.finoraTextPrimary)
                }

                // Continue Button
                Button(action: complete) {
                    Text("I've Backed Up My Keys")
                        .font(.headline)
                        .foregroundColor(.finoraTextOnPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(hasConfirmed ? Color.finoraButtonPrimary : Color.finoraBorder)
                        .cornerRadius(12)
                }
                .disabled(!hasConfirmed)
            }
            .padding(24)
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Backup Your Keys")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func complete() {
        router.completeIdentitySetup()
    }
}

#Preview {
    NavigationStack {
        KeyBackupView()
            .environmentObject(AppRouter())
    }
}
