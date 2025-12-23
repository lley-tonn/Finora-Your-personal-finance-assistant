//
//  LoginView.swift
//  Finora
//
//  Login screen view
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.brandGold, Color.brandEmerald],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Welcome to Finora")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.textPrimary)
                    
                    Text("Your personal finance assistant")
                        .font(.subheadline)
                        .foregroundColor(Color.textSecondary)
                }
                .padding(.top, 60)
                
                Spacer()
                
                // Form
                VStack(spacing: 16) {
                    CustomTextField(
                        title: "Email",
                        text: $viewModel.email,
                        keyboardType: .emailAddress,
                        autocapitalization: .never
                    )
                    
                    CustomSecureField(
                        title: "Password",
                        text: $viewModel.password
                    )
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(Color.error)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    PrimaryButton(
                        title: "Login",
                        isLoading: viewModel.isLoading,
                        isEnabled: viewModel.isFormValid
                    ) {
                        viewModel.login()
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                }
            }
            .navigationDestination(isPresented: $viewModel.isLoginSuccessful) {
                MainTabView()
            }
        }
        .onChange(of: viewModel.isLoginSuccessful) { isSuccessful in
            if isSuccessful {
                appState.isAuthenticated = true
            }
        }
    }
}

