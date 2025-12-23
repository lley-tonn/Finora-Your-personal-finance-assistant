//
//  AuthServiceTests.swift
//  FinoraTests
//
//  Unit tests for AuthService
//

import XCTest
import Combine
@testable import Finora

final class AuthServiceTests: XCTestCase {
    var authService: AuthService!
    var mockNetworkClient: MockNetworkClient!
    var sessionManager: SessionManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        sessionManager = SessionManager.shared
        authService = AuthService(networkClient: mockNetworkClient, sessionManager: sessionManager)
        cancellables = []
    }
    
    override func tearDown() {
        sessionManager.clearSession()
        cancellables = nil
        authService = nil
        sessionManager = nil
        mockNetworkClient = nil
        super.tearDown()
    }
    
    func testLogin_SavesSession() {
        // Given
        let email = "test@example.com"
        let password = "password123"
        let expectation = expectation(description: "Login completed")
        
        // When
        authService.login(email: email, password: password)
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(sessionManager.isAuthenticated)
        XCTAssertNotNil(sessionManager.currentUser)
    }
    
    func testLogout_ClearsSession() {
        // Given
        sessionManager.saveSession(token: "test_token", user: User.mock)
        XCTAssertTrue(sessionManager.isAuthenticated)
        
        // When
        authService.logout()
        
        // Then
        XCTAssertFalse(sessionManager.isAuthenticated)
        XCTAssertNil(sessionManager.currentUser)
    }
}

