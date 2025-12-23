//
//  User.swift
//  Finora
//
//  User domain model
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let profileImageURL: String?
    let createdAt: Date
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImageURL = "profile_image_url"
        case createdAt = "created_at"
    }
}

