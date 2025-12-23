//
//  StringExtensionsTests.swift
//  FinoraTests
//
//  Unit tests for String extensions
//

import XCTest
@testable import Finora

final class StringExtensionsTests: XCTestCase {
    
    func testIsValidEmail_ValidEmails() {
        let validEmails = [
            "test@example.com",
            "user.name@domain.co.uk",
            "user+tag@example.com",
            "user123@test-domain.com"
        ]
        
        for email in validEmails {
            XCTAssertTrue(email.isValidEmail, "\(email) should be valid")
        }
    }
    
    func testIsValidEmail_InvalidEmails() {
        let invalidEmails = [
            "invalid-email",
            "@example.com",
            "user@",
            "user@domain",
            "user name@example.com"
        ]
        
        for email in invalidEmails {
            XCTAssertFalse(email.isValidEmail, "\(email) should be invalid")
        }
    }
    
    func testIsValidPassword_ValidPasswords() {
        let validPasswords = [
            "password123",
            "12345678",
            "abcdefgh",
            "P@ssw0rd!"
        ]
        
        for password in validPasswords {
            XCTAssertTrue(password.isValidPassword, "\(password) should be valid")
        }
    }
    
    func testIsValidPassword_InvalidPasswords() {
        let invalidPasswords = [
            "short",
            "1234567",
            ""
        ]
        
        for password in invalidPasswords {
            XCTAssertFalse(password.isValidPassword, "\(password) should be invalid")
        }
    }
}

