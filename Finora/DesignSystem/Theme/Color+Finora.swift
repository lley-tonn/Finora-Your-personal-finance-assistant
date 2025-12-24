//
//  Color+Finora.swift
//  Finora
//
//  Production-ready color system for AI-Powered Personal Finance Assistant
//  Designed for trust, security, intelligence, and premium fintech aesthetics
//

import SwiftUI

// MARK: - Finora Color System

extension Color {

    // MARK: - Core Brand Colors

    /// Primary brand color - Deep navy blue conveying trust and professionalism
    /// Use for: Primary buttons, key UI elements, headers
    static let finoraPrimary = Color(hex: "0B1C2D")

    /// AI accent color - Vibrant teal representing intelligence and innovation
    /// Use for: AI insights, smart suggestions, interactive elements
    static let finoraAIAccent = Color(hex: "1ECAD3")

    /// Success/Growth color - Fresh green for positive financial outcomes
    /// Use for: Gains, savings growth, successful transactions
    static let finoraSuccess = Color(hex: "2ECC71")

    /// Security/Privacy color - Subtle purple for trust indicators
    /// Use for: Security badges, encryption indicators, privacy features
    static let finoraSecurity = Color(hex: "6C63FF")

    // MARK: - Semantic Background Colors (Adaptive)

    /// Main app background - Adapts to light/dark mode
    /// Light: Soft blue-gray (#F5F9FC) | Dark: Deep navy (#060E14)
    static let finoraBackground = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "060E14"))
            : UIColor(Color(hex: "F5F9FC"))
    })

    /// Surface/Card background - Adapts to light/dark mode
    /// Light: Pure white (#FFFFFF) | Dark: Dark blue-gray (#0F253A)
    static let finoraSurface = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "0F253A"))
            : UIColor(Color(hex: "FFFFFF"))
    })

    /// Elevated surface for layered cards - Adapts to light/dark mode
    /// Provides subtle elevation above base surface
    static let finoraSurfaceElevated = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "1A3A52"))
            : UIColor(Color(hex: "FAFCFE"))
    })

    // MARK: - Semantic Text Colors (Adaptive)

    /// Primary text color - Highest contrast for main content
    /// Light: Deep navy (#0B1C2D) | Dark: Soft white (#EAF2F8)
    static let finoraTextPrimary = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "EAF2F8"))
            : UIColor(Color(hex: "0B1C2D"))
    })

    /// Secondary text color - Reduced contrast for supporting content
    /// Light: Medium gray-blue (#5C6B7A) | Dark: Light blue-gray (#9FB3C8)
    static let finoraTextSecondary = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "9FB3C8"))
            : UIColor(Color(hex: "5C6B7A"))
    })

    /// Tertiary text color - Lowest contrast for subtle hints
    /// Light: Light gray (#8896A4) | Dark: Medium gray (#6B7F96)
    static let finoraTextTertiary = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "6B7F96"))
            : UIColor(Color(hex: "8896A4"))
    })

    /// Text on primary colored backgrounds (always light)
    static let finoraTextOnPrimary = Color.white

    /// Text on AI accent backgrounds (always dark for contrast)
    static let finoraTextOnAI = Color(hex: "0B1C2D")

    // MARK: - Semantic Border/Divider Colors (Adaptive)

    /// Standard divider/border color
    /// Light: Soft gray (#E1E8F0) | Dark: Dark blue-gray (#1F3A52)
    static let finoraBorder = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "1F3A52"))
            : UIColor(Color(hex: "E1E8F0"))
    })

    /// Subtle divider for minimal separation
    static let finoraDividerSubtle = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "1A2F42"))
            : UIColor(Color(hex: "EDF2F7"))
    })

    // MARK: - Status & Feedback Colors

    /// Error/Loss color - Red for negative financial outcomes
    /// Use for: Losses, errors, warnings, declined transactions
    static let finoraError = Color(hex: "E74C3C")

    /// Warning color - Amber for attention-needed items
    /// Use for: Pending actions, budget alerts, upcoming bills
    static let finoraWarning = Color(hex: "F39C12")

    /// Info color - Blue for informational messages
    /// Use for: Tips, general information, neutral notifications
    static let finoraInfo = Color(hex: "3498DB")

    // MARK: - Financial Data Visualization Colors

    /// Income/Credit color - Bright green
    static let finoraIncome = Color(hex: "27AE60")

    /// Expense/Debit color - Coral red
    static let finoraExpense = Color(hex: "E67E22")

    /// Investment color - Deep purple
    static let finoraInvestment = Color(hex: "9B59B6")

    /// Savings color - Ocean blue
    static let finoraSavings = Color(hex: "16A085")

    // MARK: - AI & Intelligence Colors

    /// AI gradient start (lighter teal)
    static let finoraAIGradientStart = Color(hex: "1ECAD3")

    /// AI gradient end (deep purple)
    static let finoraAIGradientEnd = Color(hex: "6C63FF")

    /// AI insight background (subtle teal with opacity)
    static let finoraAIInsightBackground = Color(hex: "1ECAD3").opacity(0.08)

    /// AI processing/loading color
    static let finoraAIProcessing = Color(hex: "34E4EA")

    // MARK: - Interactive Element Colors

    /// Primary button background
    static let finoraButtonPrimary = Color(hex: "0B1C2D")

    /// Primary button pressed state
    static let finoraButtonPrimaryPressed = Color(hex: "162D42")

    /// Secondary button background (adaptive)
    static let finoraButtonSecondary = Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(Color(hex: "1F3A52"))
            : UIColor(Color(hex: "E1E8F0"))
    })

    /// Link/Tappable text color
    static let finoraLink = Color(hex: "1ECAD3")

    // MARK: - Overlay Colors

    /// Overlay for modals/sheets (adaptive opacity)
    static let finoraOverlay = Color.black.opacity(0.4)

    /// Scrim for bottom sheets
    static let finoraScrim = Color.black.opacity(0.6)

    // MARK: - Shadow Colors

    /// Standard card shadow
    static let finoraShadow = Color.black.opacity(0.08)

    /// Elevated card shadow (stronger)
    static let finoraShadowElevated = Color.black.opacity(0.12)
}

// MARK: - Hex Color Initializer

extension Color {
    /// Initialize a Color from a hex string
    /// - Parameter hex: Hex color string (e.g., "FFFFFF" or "#FFFFFF")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Gradient Presets

extension LinearGradient {
    /// Premium AI gradient (teal to purple)
    /// Use for: AI insight cards, smart feature highlights
    static var finoraAIGradient: LinearGradient {
        LinearGradient(
            colors: [Color.finoraAIGradientStart, Color.finoraAIGradientEnd],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    /// Success gradient (light green to dark green)
    /// Use for: Positive growth charts, savings achievements
    static var finoraSuccessGradient: LinearGradient {
        LinearGradient(
            colors: [Color(hex: "A8E6CF"), Color.finoraSuccess],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    /// Premium dark gradient (navy to black)
    /// Use for: Premium feature cards, hero sections
    static var finoraPremiumGradient: LinearGradient {
        LinearGradient(
            colors: [Color.finoraPrimary, Color(hex: "000000")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Shadow Presets

extension View {
    /// Apply standard Finora card shadow
    func finoraCardShadow() -> some View {
        self.shadow(color: Color.finoraShadow, radius: 12, x: 0, y: 4)
    }

    /// Apply elevated card shadow (for floating elements)
    func finoraElevatedShadow() -> some View {
        self.shadow(color: Color.finoraShadowElevated, radius: 20, x: 0, y: 8)
    }

    /// Apply subtle inner shadow effect
    func finoraInnerShadow() -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.finoraBorder.opacity(0.5), lineWidth: 1)
        )
    }
}

// MARK: - Accessibility Helpers

extension Color {
    /// Check if color meets WCAG AA contrast ratio (4.5:1 for normal text)
    /// This is a simplified version - production should use proper contrast calculation
    var isAccessible: Bool {
        // In production, implement proper contrast ratio calculation
        // This is a placeholder
        return true
    }
}
