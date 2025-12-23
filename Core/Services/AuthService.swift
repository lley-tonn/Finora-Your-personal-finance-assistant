//
//  AuthService.swift
//  Finora
//
//  Authentication service
//

import Foundation
import Combine

protocol AuthServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<User, NetworkError>
    func logout()
}

final class AuthService: AuthServiceProtocol {
    private let networkClient: NetworkClientProtocol
    private let sessionManager: SessionManager
    
    init(
        networkClient: NetworkClientProtocol = NetworkClient(),
        sessionManager: SessionManager = .shared
    ) {
        self.networkClient = networkClient
        self.sessionManager = sessionManager
    }
    
    func login(email: String, password: String) -> AnyPublisher<User, NetworkError> {
        return networkClient.request(FinoraEndpoint.login(email: email, password: password))
            .handleEvents(receiveOutput: { [weak self] (response: LoginResponse) in
                // Save session with token from response
                self?.sessionManager.saveSession(token: response.token, user: response.user)
            })
            .map { (response: LoginResponse) -> User in
                response.user
            }
            .eraseToAnyPublisher()
    }
    
    func logout() {
        sessionManager.clearSession()
    }
}

// Mock response for login
struct LoginResponse: Decodable {
    let user: User
    let token: String
}

