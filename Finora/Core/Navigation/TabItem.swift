//
//  TabItem.swift
//  Finora
//
//  Tab bar item definitions for primary navigation
//  Defines icons, labels, and routes for all main tabs
//

import SwiftUI

enum TabItem: String, CaseIterable, Identifiable {
    case home
    case budget
    case insights
    case compare
    case profile

    var id: String { rawValue }

    // MARK: - Icon

    var iconName: String {
        switch self {
        case .home:
            return "chart.line.uptrend.xyaxis"
        case .budget:
            return "wallet.pass.fill"
        case .insights:
            return "sparkles"
        case .compare:
            return "chart.bar.fill"
        case .profile:
            return "person.crop.circle.fill"
        }
    }

    // MARK: - Label

    var label: String {
        switch self {
        case .home:
            return "Home"
        case .budget:
            return "Budget"
        case .insights:
            return "Insights"
        case .compare:
            return "Compare"
        case .profile:
            return "Profile"
        }
    }

    // MARK: - Route

    var route: AppRoute {
        switch self {
        case .home:
            return .dashboard
        case .budget:
            return .budgetOverview
        case .insights:
            return .aiChat
        case .compare:
            return .peerComparison
        case .profile:
            return .profile
        }
    }

    // MARK: - Accessibility

    var accessibilityLabel: String {
        switch self {
        case .home:
            return "Home tab, view your financial overview"
        case .budget:
            return "Budget tab, manage your spending"
        case .insights:
            return "Insights tab, AI-powered financial guidance"
        case .compare:
            return "Compare tab, peer benchmarking"
        case .profile:
            return "Profile tab, account and settings"
        }
    }
}
