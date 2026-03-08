//
//  ExpenseCategory.swift
//  Finora
//
//  Predefined expense categories with icons and colors
//  Used for categorizing transactions throughout the app
//

import SwiftUI

enum ExpenseCategory: String, Codable, CaseIterable, Identifiable {
    case groceries = "Groceries"
    case dining = "Dining Out"
    case transportation = "Transportation"
    case entertainment = "Entertainment"
    case shopping = "Shopping"
    case health = "Health & Wellness"
    case utilities = "Utilities"
    case housing = "Housing"
    case subscriptions = "Subscriptions"
    case travel = "Travel"
    case education = "Education"
    case personal = "Personal Care"
    case gifts = "Gifts"
    case other = "Other"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .groceries: return "cart.fill"
        case .dining: return "fork.knife"
        case .transportation: return "car.fill"
        case .entertainment: return "film.fill"
        case .shopping: return "bag.fill"
        case .health: return "heart.fill"
        case .utilities: return "bolt.fill"
        case .housing: return "house.fill"
        case .subscriptions: return "repeat"
        case .travel: return "airplane"
        case .education: return "book.fill"
        case .personal: return "person.fill"
        case .gifts: return "gift.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .groceries: return .finoraExpense
        case .dining: return .finoraWarning
        case .transportation: return .finoraInfo
        case .entertainment: return .finoraAIAccent
        case .shopping: return .finoraSecurity
        case .health: return .finoraSuccess
        case .utilities: return .finoraWarning
        case .housing: return .finoraInvestment
        case .subscriptions: return .finoraInfo
        case .travel: return .finoraAIAccent
        case .education: return .finoraSuccess
        case .personal: return .finoraSavings
        case .gifts: return .finoraExpense
        case .other: return .finoraTextSecondary
        }
    }

    /// Maps to existing BudgetCategory names for integration
    func toBudgetCategoryName() -> String {
        switch self {
        case .groceries: return "Groceries"
        case .dining: return "Dining Out"
        case .transportation: return "Transportation"
        case .entertainment: return "Entertainment"
        case .shopping: return "Shopping"
        case .health: return "Health"
        default: return "Other"
        }
    }
}
