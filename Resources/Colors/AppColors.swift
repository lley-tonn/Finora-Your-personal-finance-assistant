//
//  AppColors.swift
//  Finora
//
//  Premium Fintech Color System
//  Automatically adapts to Light/Dark Mode via system appearance
//

import SwiftUI

extension Color {
    // MARK: - Brand Colors (Static)
    
    /// Primary brand color - Near black (#0B0F19)
    /// Used for primary actions, main text, and key UI elements
    static let brandPrimary = Color(hex: "0B0F19")
    
    /// Secondary brand color - Gold (#F5C451)
    /// Used sparingly for emphasis, CTAs, and premium highlights
    static let brandGold = Color(hex: "F5C451")
    
    /// Accent color - Emerald (#10B981)
    /// Used for success states, positive metrics, and key highlights
    static let brandEmerald = Color(hex: "10B981")
    
    // MARK: - Background Colors (Adaptive)
    
    /// Primary background - adapts to light/dark mode
    /// Light: #F9FAFB (clean luxury light)
    /// Dark: #0B0F19 (premium near-black)
    static let backgroundPrimary = Color(
        light: Color(hex: "F9FAFB"),
        dark: Color(hex: "0B0F19")
    )
    
    /// Card background - adapts to light/dark mode
    /// Light: #FFFFFF (pure white)
    /// Dark: #111827 (rich dark gray)
    static let backgroundCard = Color(
        light: Color(hex: "FFFFFF"),
        dark: Color(hex: "111827")
    )
    
    /// Secondary background for elevated surfaces
    static let backgroundSecondary = Color(
        light: Color(hex: "FFFFFF"),
        dark: Color(hex: "1F2937")
    )
    
    // MARK: - Text Colors (Adaptive)
    
    /// Primary text color - main content
    /// Light: #0B0F19 (near black, crisp)
    /// Dark: #E5E7EB (soft white, avoids pure white)
    static let textPrimary = Color(
        light: Color(hex: "0B0F19"),
        dark: Color(hex: "E5E7EB")
    )
    
    /// Secondary text color - supporting content
    /// Light: #4B5563 (medium gray)
    /// Dark: #9CA3AF (light gray)
    static let textSecondary = Color(
        light: Color(hex: "4B5563"),
        dark: Color(hex: "9CA3AF")
    )
    
    /// Tertiary text color - subtle labels
    static let textTertiary = Color(
        light: Color(hex: "6B7280"),
        dark: Color(hex: "6B7280")
    )
    
    // MARK: - Action Colors (Adaptive)
    
    /// Primary action button color
    /// Light: #0B0F19 (near black)
    /// Dark: #F5C451 (gold - more prominent in dark mode)
    static let actionPrimary = Color(
        light: Color(hex: "0B0F19"),
        dark: Color(hex: "F5C451")
    )
    
    /// Primary action text (inverse of action background)
    static let actionPrimaryText = Color(
        light: .white,
        dark: Color(hex: "0B0F19")
    )
    
    /// Secondary action color
    static let actionSecondary = Color(
        light: Color(hex: "F3F4F6"),
        dark: Color(hex: "1F2937")
    )
    
    // MARK: - Accent & Highlight Colors
    
    /// Accent color for badges, key metrics, highlights
    /// Light: #F5C451 (gold - used sparingly)
    /// Dark: #10B981 (emerald - more prominent)
    static let accent = Color(
        light: Color(hex: "F5C451"),
        dark: Color(hex: "10B981")
    )
    
    /// Success state color
    static let success = Color(hex: "10B981")
    
    /// Warning state color (using gold)
    static let warning = Color(hex: "F5C451")
    
    /// Error state color (subtle red, not brand)
    static let error = Color(
        light: Color(hex: "DC2626"),
        dark: Color(hex: "EF4444")
    )
    
    // MARK: - Border & Divider Colors
    
    /// Divider and border color
    /// Light: #E5E7EB (light gray)
    /// Dark: #1F2937 (dark gray)
    static let border = Color(
        light: Color(hex: "E5E7EB"),
        dark: Color(hex: "1F2937")
    )
    
    /// Subtle border for cards
    static let borderSubtle = Color(
        light: Color(hex: "F3F4F6"),
        dark: Color(hex: "374151")
    )
    
    // MARK: - Transaction Colors
    
    /// Income/positive transaction color
    static let transactionIncome = Color(hex: "10B981")
    
    /// Expense/negative transaction color
    static let transactionExpense = Color(
        light: Color(hex: "DC2626"),
        dark: Color(hex: "F87171")
    )
    
    // MARK: - Shadow Colors
    
    /// Card shadow color (light mode only)
    static let shadowCard = Color.black.opacity(0.05)
    
    /// Elevated shadow color
    static let shadowElevated = Color.black.opacity(0.1)
}

// MARK: - Color Initialization Helpers

extension Color {
    /// Initialize color from hex string
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
    
    /// Initialize adaptive color for light/dark mode
    init(light: Color, dark: Color) {
        let lightUIColor = UIColor(light)
        let darkUIColor = UIColor(dark)
        
        self.init(uiColor: UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return darkUIColor
            default:
                return lightUIColor
            }
        })
    }
}

extension UIColor {
    /// Convert SwiftUI Color to UIColor
    init(_ color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let uiColor = UIColor(color)
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
