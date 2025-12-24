//
//  LoginView.swift
//  Finora
//
//  Login form with premium animations and refined UI
//  Includes email, password fields, biometric hint, and forgot password
//

import SwiftUI

struct LoginView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: AuthViewModel

    @State private var emailOpacity: Double = 0
    @State private var emailOffset: CGFloat = 20
    @State private var passwordOpacity: Double = 0
    @State private var passwordOffset: CGFloat = 20
    @State private var extrasOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        VStack(spacing: 24) {
            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                TextField("", text: $viewModel.loginEmail)
                    .textFieldStyle(FinoraTextFieldStyle())
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            .opacity(emailOpacity)
            .offset(y: emailOffset)

            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                SecureField("", text: $viewModel.loginPassword)
                    .textFieldStyle(FinoraTextFieldStyle())
                    .textContentType(.password)
            }
            .opacity(passwordOpacity)
            .offset(y: passwordOffset)

            // Extras (Forgot Password + Biometric)
            HStack(spacing: 16) {
                Button(action: {
                    viewModel.forgotPassword()
                }) {
                    Text("Forgot password?")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.finoraTextTertiary)
                }

                Spacer()

                // Biometric hint
                Image(systemName: "faceid")
                    .font(.system(size: 22))
                    .foregroundColor(.finoraTextTertiary)
                    .opacity(0.6)
            }
            .opacity(extrasOpacity)
            .padding(.top, 8)
        }
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Email field
        withAnimation(.easeInOut(duration: 0.6).delay(0.1)) {
            emailOpacity = 1.0
            emailOffset = 0
        }

        // Password field
        withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
            passwordOpacity = 1.0
            passwordOffset = 0
        }

        // Extras
        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            extrasOpacity = 1.0
        }
    }
}

// MARK: - Custom Text Field Style

struct FinoraTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.finoraTextPrimary)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.finoraSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.finoraBorder.opacity(0.3), lineWidth: 1)
            )
    }
}

// MARK: - Preview

#Preview {
    LoginView(viewModel: AuthViewModel())
        .padding(.horizontal, 32)
        .background(Color.finoraBackground)
        .preferredColorScheme(.dark)
}
