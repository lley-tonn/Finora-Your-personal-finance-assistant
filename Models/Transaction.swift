//
//  Transaction.swift
//  Finora
//
//  Transaction domain model
//

import Foundation

struct Transaction: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let amount: Double
    let currency: String
    let category: TransactionCategory
    let description: String
    let date: Date
    let type: TransactionType
    
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}

enum TransactionType: String, Codable {
    case income
    case expense
}

enum TransactionCategory: String, Codable, CaseIterable {
    case food
    case transportation
    case shopping
    case entertainment
    case bills
    case healthcare
    case education
    case salary
    case investment
    case other
    
    var displayName: String {
        rawValue.capitalized
    }
    
    var icon: String {
        switch self {
        case .food: return "fork.knife"
        case .transportation: return "car.fill"
        case .shopping: return "bag.fill"
        case .entertainment: return "tv.fill"
        case .bills: return "doc.text.fill"
        case .healthcare: return "cross.case.fill"
        case .education: return "book.fill"
        case .salary: return "dollarsign.circle.fill"
        case .investment: return "chart.line.uptrend.xyaxis"
        case .other: return "ellipsis.circle.fill"
        }
    }
}

