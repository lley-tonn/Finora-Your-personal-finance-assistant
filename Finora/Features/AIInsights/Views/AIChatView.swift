//
//  AIChatView.swift
//  Finora
//

import SwiftUI

struct AIChatView: View {
    @EnvironmentObject private var router: AppRouter
    @State private var messageText = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    AIMessage(text: "Hello! I'm your AI financial assistant. How can I help you today?", isUser: false)
                    AIMessage(text: "Show me my spending trends", isUser: true)
                    AIMessage(text: "Your spending has increased by 15% this month, mainly in dining and entertainment.", isUser: false)
                }
                .padding()
            }

            HStack {
                TextField("Ask anything...", text: $messageText)
                    .textFieldStyle(.roundedBorder)

                Button(action: {}) {
                    Image(systemName: "paperplane.fill")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("AI Assistant")
    }
}

struct AIMessage: View {
    let text: String
    let isUser: Bool

    var body: some View {
        HStack {
            if isUser { Spacer() }
            Text(text)
                .padding()
                .background(isUser ? Color.finoraPrimary : Color.finoraSurface)
                .foregroundColor(isUser ? .white : .primary)
                .cornerRadius(12)
            if !isUser { Spacer() }
        }
    }
}
