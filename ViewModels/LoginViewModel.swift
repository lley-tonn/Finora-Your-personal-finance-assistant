//
//  LoginViewModel.swift
//  Finora
//
//  Login screen ViewModel
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoginSuccessful: Bool = false
    
    // MARK: - Dependencies
    private let authService: AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    var isFormValid: Bool {
        email.isValidEmail && password.isValidPassword
    }
    
    // MARK: - Initialization
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    // MARK: - Public Methods
    func login() {
        guard isFormValid else {
            errorMessage = "Please enter a valid email and password"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        authService.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] user in
                    self?.isLoginSuccessful = true
                }
            )
            .store(in: &cancellables)
    }
}

