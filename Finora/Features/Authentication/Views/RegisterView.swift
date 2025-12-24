//
//  RegisterView.swift
//  Finora
//
//  New user registration with email and password
//  First step in creating a Finora account
//

import SwiftUI

struct RegisterView: View {

    @EnvironmentObject private var router: AppRouter

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var agreedToTerms = false
    @State private var isLoading = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "person.badge.plus.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.finoraPrimary)

                    Text("Create Account")
                        .font(.largeTitle.bold())
                        .foregroundColor(.finoraTextPrimary)

                    Text("Start your journey to financial clarity")
                        .font(.subheadline)
                        .foregroundColor(.finoraTextSecondary)
                }
                .padding(.top, 40)

                // Registration Form
                VStack(spacing: 16) {
                    CustomTextField(title: "Email", placeholder: "your@email.com", text: $email)
                    CustomSecureField(title: "Password", placeholder: "••••••••", text: $password)
                    CustomSecureField(title: "Confirm Password", placeholder: "••••••••", text: $confirmPassword)

                    // Terms and Privacy
                    Toggle(isOn: $agreedToTerms) {
                        HStack(spacing: 4) {
                            Text("I agree to the")
                            Button("Terms") {}
                                .foregroundColor(.finoraLink)
                            Text("and")
                            Button("Privacy Policy") {}
                                .foregroundColor(.finoraLink)
                        }
                        .font(.caption)
                        .foregroundColor(.finoraTextSecondary)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                }

                // Register Button
                Button(action: register) {
                    Text(isLoading ? "Creating Account..." : "Create Account")
                        .font(.headline)
                        .foregroundColor(.finoraTextOnPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(agreedToTerms ? Color.finoraButtonPrimary : Color.finoraBorder)
                        .cornerRadius(12)
                }
                .disabled(!agreedToTerms || isLoading)

                // Login Link
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.finoraTextSecondary)

                    Button(action: { router.navigateBack() }) {
                        Text("Login")
                            .foregroundColor(.finoraLink)
                            .fontWeight(.semibold)
                    }
                }
                .font(.subheadline)
            }
            .padding(24)
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func register() {
        isLoading = true
        // TODO: Implement registration logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
            router.navigate(to: .biometricSetup)
        }
    }
}

// MARK: - Helper Components

private struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundColor(.finoraTextPrimary)

            TextField(placeholder, text: $text)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.finoraSurface)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.finoraBorder, lineWidth: 1))
        }
    }
}

private struct CustomSecureField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundColor(.finoraTextPrimary)

            SecureField(placeholder, text: $text)
                .padding()
                .background(Color.finoraSurface)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.finoraBorder, lineWidth: 1))
        }
    }
}

private struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .foregroundColor(configuration.isOn ? .finoraPrimary : .finoraBorder)
                .onTapGesture { configuration.isOn.toggle() }

            configuration.label
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environmentObject(AppRouter())
    }
}
