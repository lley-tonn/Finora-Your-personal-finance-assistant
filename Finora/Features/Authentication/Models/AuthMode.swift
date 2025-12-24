//
//  AuthMode.swift
//  Finora
//
//  Authentication mode enumeration
//  Defines login vs register states
//

import Foundation

enum AuthMode: String, CaseIterable {
    case login = "Login"
    case register = "Register"

    var ctaTitle: String {
        switch self {
        case .login:
            return "Continue Securely"
        case .register:
            return "Create Private Account"
        }
    }
}
