//
//  AppRoute.swift
//  Finora
//
//  Defines all navigation routes in the app
//  Organized by user flow from onboarding to main features
//

import SwiftUI

enum AppRoute: Hashable {

    // MARK: - Onboarding Flow

    case onboarding
    case privacyIntro

    // MARK: - Authentication Flow

    case login
    case register
    case biometricSetup

    // MARK: - Identity & Security Flow

    case keyGeneration
    case keyBackup

    // MARK: - Main App Flow

    case dashboard
    case budgetOverview
    case budgetEdit
    case investmentOverview
    case riskProfile
    case debtOverview
    case debtStrategy
    case peerComparison
    case aiChat
    case aiInsightDetail(insight: String)
    case settings
    case dataControl

    // MARK: - View Builder

    @ViewBuilder
    var view: some View {
        switch self {
        // Onboarding
        case .onboarding:
            OnboardingView()
        case .privacyIntro:
            PrivacyIntroView()

        // Authentication
        case .login:
            LoginView()
        case .register:
            RegisterView()
        case .biometricSetup:
            BiometricSetupView()

        // Identity
        case .keyGeneration:
            KeyGenerationView()
        case .keyBackup:
            KeyBackupView()

        // Main Features
        case .dashboard:
            DashboardView()
        case .budgetOverview:
            BudgetOverviewView()
        case .budgetEdit:
            BudgetEditView()
        case .investmentOverview:
            InvestmentOverviewView()
        case .riskProfile:
            RiskProfileView()
        case .debtOverview:
            DebtOverviewView()
        case .debtStrategy:
            DebtStrategyView()
        case .peerComparison:
            PeerComparisonView()
        case .aiChat:
            AIChatView()
        case .aiInsightDetail(let insight):
            AIInsightDetailView(insight: insight)
        case .settings:
            SettingsView()
        case .dataControl:
            DataControlView()
        }
    }
}
