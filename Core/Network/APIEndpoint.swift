//
//  APIEndpoint.swift
//  Finora
//
//  API endpoint definitions
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case decodingError(Error)
    case unauthorized
    case serverError(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized access"
        case .serverError(let code):
            return "Server error with code: \(code)"
        }
    }
}

// Example endpoints
enum FinoraEndpoint: APIEndpoint {
    case login(email: String, password: String)
    case getUserProfile
    case getTransactions
    case createTransaction(Transaction)
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .getUserProfile:
            return "/user/profile"
        case .getTransactions:
            return "/transactions"
        case .createTransaction:
            return "/transactions"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .createTransaction:
            return .post
        case .getUserProfile, .getTransactions:
            return .get
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Accept": "application/json"]
        
        // Add auth token if available
        if let token = SessionManager.shared.authToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    var body: Encodable? {
        switch self {
        case .login(let email, let password):
            return LoginRequest(email: email, password: password)
        case .createTransaction(let transaction):
            return transaction
        default:
            return nil
        }
    }
}

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

