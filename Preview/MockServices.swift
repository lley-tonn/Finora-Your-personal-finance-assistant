//
//  MockServices.swift
//  Finora
//
//  Mock services for previews and testing
//

import Foundation
import Combine

final class MockAuthService: AuthServiceProtocol {
    var shouldSucceed: Bool = true
    var delay: TimeInterval = 0.5
    
    func login(email: String, password: String) -> AnyPublisher<User, NetworkError> {
        if shouldSucceed {
            return Just(User.mock)
                .delay(for: .seconds(delay), scheduler: DispatchQueue.main)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.unauthorized)
                .delay(for: .seconds(delay), scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
    
    func logout() {
        // Mock implementation
    }
}

final class MockNetworkClient: NetworkClientProtocol {
    var mockTransactions: [Transaction] = Transaction.mockTransactions
    var shouldLoginSucceed: Bool = true
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> {
        if endpoint.path.contains("transactions") && endpoint.method == .get {
            let response = TransactionsResponse(transactions: mockTransactions)
            return Just(response as! T)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        if endpoint.path.contains("login") {
            if shouldLoginSucceed {
                let response = LoginResponse(user: User.mock, token: "mock_token_123")
                return Just(response as! T)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NetworkError.unauthorized)
                    .eraseToAnyPublisher()
            }
        }
        
        return Fail(error: NetworkError.requestFailed(NSError(domain: "Mock", code: 0)))
            .eraseToAnyPublisher()
    }
}

