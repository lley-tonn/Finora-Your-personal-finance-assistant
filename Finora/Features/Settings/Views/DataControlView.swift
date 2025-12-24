//
//  DataControlView.swift
//  Finora
//

import SwiftUI

struct DataControlView: View {
    var body: some View {
        Form {
            Section("Your Data") {
                Text("All your financial data is encrypted and stored on decentralized networks (IPFS).")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Section("Data Management") {
                Button("Export All Data") {}
                Button("Delete All Data", role: .destructive) {}
            }

            Section("Blockchain Records") {
                HStack {
                    Text("Public Key")
                    Spacer()
                    Text("did:example:123...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Button("View Blockchain History") {}
            }

            Section("Privacy") {
                Toggle("Anonymous Benchmarking", isOn: .constant(true))
                Toggle("Share Anonymous Stats", isOn: .constant(false))
            }
        }
        .navigationTitle("Data Control")
    }
}

#Preview {
    NavigationStack {
        DataControlView()
    }
}
