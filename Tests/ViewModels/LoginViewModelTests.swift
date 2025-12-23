//
//  LoginViewModelTests.swift
//  FinoraTests
//
//  Unit tests for LoginViewModel
//

import XCTest
import Combine
@testable import Finora

@MainActor
final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockAuthService: MockAuthService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthService()
        viewModel = LoginViewModel(authService: mockAuthService)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockAuthService = nil
        super.tearDown()
    }
    
    func testFormValidation_ValidInput() {
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        
        XCTAssertTrue(viewModel.isFormValid)
    }
    
    func testFormValidation_InvalidEmail() {
        viewModel.email = "invalid-email"
        viewModel.password = "password123"
        
        XCTAssertFalse(viewModel.isFormValid)
    }
    
    func testFormValidation_ShortPassword() {
        viewModel.email = "test@example.com"
        viewModel.password = "short"
        
        XCTAssertFalse(viewModel.isFormValid)
    }
    
    func testLogin_Success() {
        // Given
        mockAuthService.shouldSucceed = true
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        
        let expectation = expectation(description: "Login successful")
        
        viewModel.$isLoginSuccessful
            .dropFirst()
            .sink { isSuccessful in
                if isSuccessful {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        viewModel.login()
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(viewModel.isLoginSuccessful)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLogin_Failure() {
        // Given
        mockAuthService.shouldSucceed = false
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        
        let expectation = expectation(description: "Login failed")
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.login()
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertFalse(viewModel.isLoginSuccessful)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}

