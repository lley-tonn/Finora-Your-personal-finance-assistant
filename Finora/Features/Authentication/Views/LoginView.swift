//
//  LoginView.swift
//  Finora
//
//  User login screen with email/password or biometric authentication
//  Entry point for returning users
//

import SwiftUI

struct LoginView: View {

    // MARK: - Environment

    @EnvironmentObject private var router: AppRouter

    // MARK: - State

    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var isLoading = false

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.finoraPrimary)

                    Text("Welcome Back")
                        .font(.largeTitle.bold())
                        .foregroundColor(.finoraTextPrimary)

                    Text("Login to access your financial insights")
                        .font(.subheadline)
                        .foregroundColor(.finoraTextSecondary)
                }
                .padding(.top, 40)

                // Login Form
                VStack(spacing: 16) {
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.finoraTextPrimary)

                        TextField("your@email.com", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.finoraSurface)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.finoraBorder, lineWidth: 1)
                            )
                    }

                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.finoraTextPrimary)

                        HStack {
                            if showPassword {
                                TextField("••••••••", text: $password)
                            } else {
                                SecureField("••••••••", text: $password)
                            }

                            Button(action: { showPassword.toggle() }) {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.finoraTextTertiary)
                            }
                        }
                        .padding()
                        .background(Color.finoraSurface)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.finoraBorder, lineWidth: 1)
                        )
                    }

                    // Forgot Password
                    Button(action: {}) {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(.finoraLink)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                // Login Button
                Button(action: login) {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Login")
                            .font(.headline)
                    }
                }
                .foregroundColor(.finoraTextOnPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.finoraButtonPrimary)
                .cornerRadius(12)
                .disabled(isLoading)

                // Biometric Login
                Button(action: loginWithBiometric) {
                    HStack {
                        Image(systemName: "faceid")
                        Text("Login with Face ID")
                    }
                    .font(.headline)
                    .foregroundColor(.finoraTextPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.finoraButtonSecondary)
                    .cornerRadius(12)
                }

                // Register Link
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.finoraTextSecondary)

                    Button(action: { router.navigate(to: .register) }) {
                        Text("Sign Up")
                            .foregroundColor(.finoraLink)
                            .fontWeight(.semibold)
                    }
                }
                .font(.subheadline)
            }
            .padding(24)
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Methods

    private func login() {
        isLoading = true

        // TODO: Implement actual authentication
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
            router.completeAuthentication()
        }
    }

    private func loginWithBiometric() {
        // TODO: Implement biometric authentication
        router.completeAuthentication()
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AppRouter())
    }
}
