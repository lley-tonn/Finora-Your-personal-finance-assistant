//
//  AppConstants.swift
//  Finora
//
//  Application-wide constants
//

import Foundation

enum AppConstants {
    enum API {
        static let baseURL = "https://api.finora.com"
        static let timeout: TimeInterval = 30
    }
    
    enum UserDefaults {
        static let isOnboardingCompleted = "is_onboarding_completed"
        static let selectedCurrency = "selected_currency"
    }
    
    enum Animation {
        static let defaultDuration: Double = 0.3
        static let springResponse: Double = 0.5
        static let springDamping: Double = 0.8
    }
}

