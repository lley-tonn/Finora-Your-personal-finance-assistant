//
//  NetworkClient.swift
//  Finora
//
//  Generic API client for network requests
//

import Foundation
import Combine

protocol NetworkClientProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError>
}

final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let baseURL: String
    
    init(session: URLSession = .shared, baseURL: String = "https://api.finora.com") {
        self.session = session
        self.baseURL = baseURL
    }
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: baseURL + endpoint.path) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if error is DecodingError {
                    return .decodingError(error)
                }
                return .requestFailed(error)
            }
            .eraseToAnyPublisher()
    }
}

