//
//  PrimaryButton.swift
//  Finora
//
//  Primary action button component
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isLoading: Bool = false
    var isEnabled: Bool = true
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.actionPrimaryText))
                } else {
                    Text(title)
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(isEnabled ? Color.actionPrimary : Color.border)
            .foregroundColor(isEnabled ? Color.actionPrimaryText : Color.textSecondary)
            .cornerRadius(12)
        }
        .disabled(!isEnabled || isLoading)
    }
}

