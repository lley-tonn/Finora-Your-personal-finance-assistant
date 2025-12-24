//
//  RegisterView.swift
//  Finora
//
//  Registration form with premium animations and refined UI
//  Includes full name, email, password fields, and privacy acknowledgment
//

import SwiftUI

struct RegisterView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: AuthViewModel

    @State private var nameOpacity: Double = 0
    @State private var nameOffset: CGFloat = 20
    @State private var emailOpacity: Double = 0
    @State private var emailOffset: CGFloat = 20
    @State private var passwordOpacity: Double = 0
    @State private var passwordOffset: CGFloat = 20
    @State private var confirmPasswordOpacity: Double = 0
    @State private var confirmPasswordOffset: CGFloat = 20
    @State private var privacyOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        VStack(spacing: 24) {
            // Full Name Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Full Name")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                TextField("", text: $viewModel.registerFullName)
                    .textFieldStyle(FinoraTextFieldStyle())
                    .textContentType(.name)
                    .autocapitalization(.words)
            }
            .opacity(nameOpacity)
            .offset(y: nameOffset)

            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                TextField("", text: $viewModel.registerEmail)
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

                SecureField("", text: $viewModel.registerPassword)
                    .textFieldStyle(FinoraTextFieldStyle())
                    .textContentType(.newPassword)
            }
            .opacity(passwordOpacity)
            .offset(y: passwordOffset)

            // Confirm Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm Password")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextSecondary)

                SecureField("", text: $viewModel.registerConfirmPassword)
                    .textFieldStyle(FinoraTextFieldStyle())
                    .textContentType(.newPassword)
            }
            .opacity(confirmPasswordOpacity)
            .offset(y: confirmPasswordOffset)

            // Privacy Acknowledgment
            VStack(alignment: .leading, spacing: 8) {
                Text("By creating an account, you agree to our")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.finoraTextTertiary)
                +
                Text(" Terms of Service ")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.finoraLink)
                +
                Text("and")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.finoraTextTertiary)
                +
                Text(" Privacy Policy")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.finoraLink)
            }
            .opacity(privacyOpacity)
            .padding(.top, 8)
        }
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Full Name field
        withAnimation(.easeInOut(duration: 0.6).delay(0.1)) {
            nameOpacity = 1.0
            nameOffset = 0
        }

        // Email field
        withAnimation(.easeInOut(duration: 0.6).delay(0.15)) {
            emailOpacity = 1.0
            emailOffset = 0
        }

        // Password field
        withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
            passwordOpacity = 1.0
            passwordOffset = 0
        }

        // Confirm Password field
        withAnimation(.easeInOut(duration: 0.6).delay(0.25)) {
            confirmPasswordOpacity = 1.0
            confirmPasswordOffset = 0
        }

        // Privacy acknowledgment
        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            privacyOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    RegisterView(viewModel: AuthViewModel())
        .padding(.horizontal, 32)
        .background(Color.finoraBackground)
        .preferredColorScheme(.dark)
}
