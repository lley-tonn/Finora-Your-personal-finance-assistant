//
//  ProfileItem.swift
//  Finora
//
//  Model for profile sections and rows
//  Defines structure for security, privacy, and preferences
//

import SwiftUI

// MARK: - Profile Section

enum ProfileSection: String, CaseIterable, Identifiable {
    case security = "Security & Identity"
    case dataControl = "Data Control & Privacy"
    case aiTransparency = "AI Transparency"
    case peerBenchmarking = "Peer Benchmarking"
    case financialPrefs = "Financial Preferences"
    case appPrefs = "App Preferences"
    case support = "Support & Legal"

    var id: String { rawValue }

    var items: [ProfileItem] {
        switch self {
        case .security:
            return [
                ProfileItem(
                    icon: "key.fill",
                    title: "Private Key Status",
                    subtitle: "Your encryption keys are secure",
                    color: .finoraSecurity,
                    action: .detail(.keyStatus)
                ),
                ProfileItem(
                    icon: "doc.text.fill",
                    title: "Backup Recovery Phrase",
                    subtitle: "View your 12-word backup phrase",
                    color: .finoraWarning,
                    action: .detail(.backupPhrase)
                ),
                ProfileItem(
                    icon: "faceid",
                    title: "Biometric Authentication",
                    subtitle: "Face ID enabled",
                    color: .finoraInfo,
                    action: .detail(.biometric)
                ),
                ProfileItem(
                    icon: "laptopcomputer.and.iphone",
                    title: "Active Sessions",
                    subtitle: "2 devices connected",
                    color: .finoraTextSecondary,
                    action: .detail(.sessions)
                )
            ]

        case .dataControl:
            return [
                ProfileItem(
                    icon: "doc.badge.ellipsis",
                    title: "View Data Hashes",
                    subtitle: "Cryptographic proof of your data",
                    color: .finoraAIAccent,
                    action: .detail(.dataHashes)
                ),
                ProfileItem(
                    icon: "square.and.arrow.up.fill",
                    title: "Export Encrypted Data",
                    subtitle: "Download your financial records",
                    color: .finoraSuccess,
                    action: .detail(.exportData)
                ),
                ProfileItem(
                    icon: "hand.raised.fill",
                    title: "Revoke Access",
                    subtitle: "Remove third-party permissions",
                    color: .finoraWarning,
                    action: .detail(.revokeAccess)
                ),
                ProfileItem(
                    icon: "trash.fill",
                    title: "Delete Stored Data",
                    subtitle: "Permanently remove local data",
                    color: .finoraExpense,
                    action: .detail(.deleteData),
                    isDestructive: true
                )
            ]

        case .aiTransparency:
            return [
                ProfileItem(
                    icon: "brain.head.profile",
                    title: "How AI Works",
                    subtitle: "Understand insight generation",
                    color: .finoraAIAccent,
                    action: .detail(.howAIWorks)
                ),
                ProfileItem(
                    icon: "chart.bar.doc.horizontal.fill",
                    title: "Data Sources Used",
                    subtitle: "What powers your insights",
                    color: .finoraInfo,
                    action: .detail(.dataSources)
                ),
                ProfileItem(
                    icon: "slider.horizontal.3",
                    title: "Personalization Level",
                    subtitle: "Balanced",
                    color: .finoraAIAccent,
                    action: .detail(.personalization)
                ),
                ProfileItem(
                    icon: "sparkles",
                    title: "AI Insights",
                    subtitle: "Enabled",
                    color: .finoraAIAccent,
                    action: .toggle(.aiInsights, true)
                )
            ]

        case .peerBenchmarking:
            return [
                ProfileItem(
                    icon: "chart.bar.fill",
                    title: "Anonymous Benchmarking",
                    subtitle: "Opt-in to compare with peers",
                    color: .finoraInfo,
                    action: .toggle(.peerBenchmarking, false)
                ),
                ProfileItem(
                    icon: "shield.checkered",
                    title: "Anonymization Info",
                    subtitle: "How your data is protected",
                    color: .finoraSecurity,
                    action: .detail(.anonymization)
                ),
                ProfileItem(
                    icon: "arrow.counterclockwise",
                    title: "Reset Peer Data",
                    subtitle: "Clear comparison history",
                    color: .finoraTextSecondary,
                    action: .detail(.resetPeerData)
                )
            ]

        case .financialPrefs:
            return [
                ProfileItem(
                    icon: "dollarsign.circle.fill",
                    title: "Currency",
                    subtitle: "USD ($)",
                    color: .finoraSuccess,
                    action: .detail(.currency)
                ),
                ProfileItem(
                    icon: "calendar",
                    title: "Monthly Cycle Start",
                    subtitle: "1st of the month",
                    color: .finoraInfo,
                    action: .detail(.cycleStart)
                ),
                ProfileItem(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Risk Tolerance",
                    subtitle: "Moderate",
                    color: .finoraInvestment,
                    action: .detail(.riskTolerance)
                ),
                ProfileItem(
                    icon: "bell.fill",
                    title: "Notifications",
                    subtitle: "Budget alerts enabled",
                    color: .finoraWarning,
                    action: .detail(.notifications)
                )
            ]

        case .appPrefs:
            return [
                ProfileItem(
                    icon: "moon.fill",
                    title: "Theme",
                    subtitle: "Dark",
                    color: .finoraTextSecondary,
                    action: .detail(.theme)
                ),
                ProfileItem(
                    icon: "globe",
                    title: "Language",
                    subtitle: "English",
                    color: .finoraInfo,
                    action: .detail(.language)
                ),
                ProfileItem(
                    icon: "figure.walk.motion",
                    title: "Reduced Motion",
                    subtitle: "Off",
                    color: .finoraTextSecondary,
                    action: .toggle(.reducedMotion, false)
                ),
                ProfileItem(
                    icon: "accessibility",
                    title: "Accessibility",
                    subtitle: "Customize display options",
                    color: .finoraSuccess,
                    action: .detail(.accessibility)
                )
            ]

        case .support:
            return [
                ProfileItem(
                    icon: "questionmark.circle.fill",
                    title: "Help & Support",
                    subtitle: "Get assistance",
                    color: .finoraInfo,
                    action: .detail(.help)
                ),
                ProfileItem(
                    icon: "hand.raised.fill",
                    title: "Privacy Policy",
                    subtitle: "How we protect your data",
                    color: .finoraSecurity,
                    action: .detail(.privacyPolicy)
                ),
                ProfileItem(
                    icon: "doc.text.fill",
                    title: "Terms of Service",
                    subtitle: "Usage agreement",
                    color: .finoraTextSecondary,
                    action: .detail(.terms)
                ),
                ProfileItem(
                    icon: "info.circle.fill",
                    title: "About Finora",
                    subtitle: "Version 1.0.0",
                    color: .finoraAIAccent,
                    action: .detail(.about)
                )
            ]
        }
    }
}

// MARK: - Profile Item

struct ProfileItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let action: ProfileAction
    var isDestructive: Bool = false
}

// MARK: - Profile Action

enum ProfileAction {
    case detail(ProfileDetailType)
    case toggle(ProfileToggleType, Bool)
}

// MARK: - Profile Detail Type

enum ProfileDetailType {
    // Security
    case keyStatus
    case backupPhrase
    case biometric
    case sessions

    // Data Control
    case dataHashes
    case exportData
    case revokeAccess
    case deleteData

    // AI Transparency
    case howAIWorks
    case dataSources
    case personalization

    // Peer Benchmarking
    case anonymization
    case resetPeerData

    // Financial Prefs
    case currency
    case cycleStart
    case riskTolerance
    case notifications

    // App Prefs
    case theme
    case language
    case accessibility

    // Support
    case help
    case privacyPolicy
    case terms
    case about

    var title: String {
        switch self {
        case .keyStatus: return "Private Key Status"
        case .backupPhrase: return "Recovery Phrase"
        case .biometric: return "Biometric Authentication"
        case .sessions: return "Active Sessions"
        case .dataHashes: return "Data Hashes"
        case .exportData: return "Export Data"
        case .revokeAccess: return "Revoke Access"
        case .deleteData: return "Delete Data"
        case .howAIWorks: return "How AI Works"
        case .dataSources: return "Data Sources"
        case .personalization: return "Personalization"
        case .anonymization: return "Anonymization"
        case .resetPeerData: return "Reset Peer Data"
        case .currency: return "Currency"
        case .cycleStart: return "Monthly Cycle"
        case .riskTolerance: return "Risk Tolerance"
        case .notifications: return "Notifications"
        case .theme: return "Theme"
        case .language: return "Language"
        case .accessibility: return "Accessibility"
        case .help: return "Help & Support"
        case .privacyPolicy: return "Privacy Policy"
        case .terms: return "Terms of Service"
        case .about: return "About Finora"
        }
    }
}

// MARK: - Profile Toggle Type

enum ProfileToggleType {
    case aiInsights
    case peerBenchmarking
    case reducedMotion
}
