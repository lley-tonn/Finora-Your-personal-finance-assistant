//
//  ProfileDetailView.swift
//  Finora
//
//  Detail screen for profile items
//  Placeholder content for various settings and information
//

import SwiftUI

struct ProfileDetailView: View {

    // MARK: - Properties

    let detailType: ProfileDetailType

    @State private var contentOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 40)

                // Icon
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.15))
                        .frame(width: 80, height: 80)

                    Image(systemName: iconName)
                        .font(.system(size: 36, weight: .light))
                        .foregroundColor(iconColor)
                }

                // Title
                Text(detailType.title)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                // Content
                contentView
                    .padding(.horizontal, 32)

                Spacer()
            }
            .opacity(contentOpacity)
        }
        .background(Color.finoraBackground.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Content View

    @ViewBuilder
    private var contentView: some View {
        VStack(spacing: 20) {
            Text(contentText)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.finoraTextSecondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            if showPlaceholderCard {
                placeholderCard
            }
        }
    }

    private var placeholderCard: some View {
        VStack(spacing: 16) {
            Text("Feature Coming Soon")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.finoraTextPrimary)

            Text("This feature will be available in a future update with full decentralized data control.")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.finoraTextSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.finoraSurface)
        )
    }

    // MARK: - Content Data

    private var iconName: String {
        switch detailType {
        case .keyStatus: return "key.fill"
        case .backupPhrase: return "doc.text.fill"
        case .biometric: return "faceid"
        case .sessions: return "laptopcomputer.and.iphone"
        case .dataHashes: return "doc.badge.ellipsis"
        case .exportData: return "square.and.arrow.up.fill"
        case .revokeAccess: return "hand.raised.fill"
        case .deleteData: return "trash.fill"
        case .howAIWorks: return "brain.head.profile"
        case .dataSources: return "chart.bar.doc.horizontal.fill"
        case .personalization: return "slider.horizontal.3"
        case .anonymization: return "shield.checkered"
        case .resetPeerData: return "arrow.counterclockwise"
        case .currency: return "dollarsign.circle.fill"
        case .cycleStart: return "calendar"
        case .riskTolerance: return "chart.line.uptrend.xyaxis"
        case .notifications: return "bell.fill"
        case .theme: return "moon.fill"
        case .language: return "globe"
        case .accessibility: return "accessibility"
        case .help: return "questionmark.circle.fill"
        case .privacyPolicy: return "hand.raised.fill"
        case .terms: return "doc.text.fill"
        case .about: return "info.circle.fill"
        }
    }

    private var iconColor: Color {
        switch detailType {
        case .keyStatus, .biometric, .anonymization: return .finoraSecurity
        case .backupPhrase, .revokeAccess, .notifications: return .finoraWarning
        case .exportData, .accessibility: return .finoraSuccess
        case .deleteData: return .finoraExpense
        case .howAIWorks, .personalization, .about: return .finoraAIAccent
        case .dataSources, .sessions, .help: return .finoraInfo
        case .dataHashes, .resetPeerData, .cycleStart, .theme, .language, .privacyPolicy, .terms: return .finoraTextSecondary
        case .currency: return .finoraSuccess
        case .riskTolerance: return .finoraInvestment
        }
    }

    private var contentText: String {
        switch detailType {
        case .keyStatus:
            return "Your private encryption keys are securely stored on this device. No one else has access to them, including Finora."
        case .backupPhrase:
            return "Your 12-word recovery phrase allows you to restore access to your encrypted data. Keep it safe and never share it."
        case .biometric:
            return "Face ID provides quick, secure access to your financial data without compromising encryption."
        case .sessions:
            return "View and manage devices with access to your encrypted financial data."
        case .dataHashes:
            return "Cryptographic hashes provide proof that your data hasn't been tampered with."
        case .exportData:
            return "Download an encrypted backup of your financial data. Your data remains encrypted until you decrypt it with your private key."
        case .revokeAccess:
            return "Remove permissions from third-party services that may have accessed your data."
        case .deleteData:
            return "Permanently delete all locally stored financial data. This action cannot be undone."
        case .howAIWorks:
            return "Understand how AI insights are formed. Our AI analyzes your spending patterns and financial behavior to provide personalized recommendations."
        case .dataSources:
            return "Learn which data sources power your insights and how they're used to create personalized financial guidance."
        case .personalization:
            return "Adjust how personalized your AI insights are. Higher personalization means more tailored recommendations."
        case .anonymization:
            return "Your data is anonymized using cryptographic techniques before peer comparison. No personal information is ever shared."
        case .resetPeerData:
            return "Clear your peer comparison history and start fresh. This won't affect your personal financial data."
        case .currency:
            return "Select your preferred currency for displaying amounts throughout the app."
        case .cycleStart:
            return "Choose which day of the month starts your financial cycle for budgeting and reporting."
        case .riskTolerance:
            return "Set your investment risk tolerance to receive appropriate investment recommendations."
        case .notifications:
            return "Customize which financial alerts and insights you'd like to receive."
        case .theme:
            return "Choose your preferred color theme for the app interface."
        case .language:
            return "Select your preferred language for the app interface."
        case .accessibility:
            return "Customize display options for better accessibility, including text size and contrast."
        case .help:
            return "Get assistance with using Finora and managing your financial data."
        case .privacyPolicy:
            return "Read our commitment to protecting your data and maintaining your privacy."
        case .terms:
            return "Review the terms of service for using Finora."
        case .about:
            return "Finora is an AI-powered personal finance assistant built on principles of data ownership and privacy. Version 1.0.0"
        }
    }

    private var showPlaceholderCard: Bool {
        switch detailType {
        case .keyStatus, .backupPhrase, .biometric, .sessions, .dataHashes, .exportData, .revokeAccess, .deleteData:
            return true
        case .resetPeerData, .notifications, .accessibility:
            return true
        default:
            return false
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.6).delay(0.1)) {
            contentOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ProfileDetailView(detailType: .keyStatus)
    }
}
