//
//  MockData.swift
//  Finora
//
//  Mock data for previews and testing
//

import Foundation

extension User {
    static let mock = User(
        id: "1",
        email: "john.doe@example.com",
        firstName: "John",
        lastName: "Doe",
        profileImageURL: nil,
        createdAt: Date()
    )
}

extension Transaction {
    static let mockTransactions: [Transaction] = [
        Transaction(
            id: "1",
            amount: 1500.00,
            currency: "USD",
            category: .salary,
            description: "Monthly Salary",
            date: Date().addingTimeInterval(-86400 * 5),
            type: .income
        ),
        Transaction(
            id: "2",
            amount: 45.50,
            currency: "USD",
            category: .food,
            description: "Grocery Shopping",
            date: Date().addingTimeInterval(-86400 * 2),
            type: .expense
        ),
        Transaction(
            id: "3",
            amount: 120.00,
            currency: "USD",
            category: .transportation,
            description: "Gas Station",
            date: Date().addingTimeInterval(-86400),
            type: .expense
        ),
        Transaction(
            id: "4",
            amount: 29.99,
            currency: "USD",
            category: .entertainment,
            description: "Netflix Subscription",
            date: Date(),
            type: .expense
        )
    ]
}

