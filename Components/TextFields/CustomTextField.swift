//
//  CustomTextField.swift
//  Finora
//
//  Custom text field component
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color.textSecondary)
            
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .foregroundColor(Color.textPrimary)
                .padding()
                .background(Color.actionSecondary)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.border, lineWidth: 1)
                )
        }
    }
}

struct CustomSecureField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color.textSecondary)
            
            SecureField("", text: $text)
                .textFieldStyle(.plain)
                .foregroundColor(Color.textPrimary)
                .padding()
                .background(Color.actionSecondary)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.border, lineWidth: 1)
                )
        }
    }
}

