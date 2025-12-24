//
//  SettingsView.swift
//  Finora
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        Form {
            Section("Account") {
                HStack {
                    Text("Email")
                    Spacer()
                    Text("user@example.com")
                        .foregroundColor(.secondary)
                }
            }

            Section("Privacy & Security") {
                Toggle("Biometric Login", isOn: .constant(true))

                Button("Data Control") {
                    router.navigate(to: .dataControl)
                }
            }

            Section("Preferences") {
                Toggle("Dark Mode", isOn: .constant(false))
                Toggle("Notifications", isOn: .constant(true))
            }

            Section {
                Button("Logout", role: .destructive) {
                    router.logout()
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(AppRouter())
    }
}
