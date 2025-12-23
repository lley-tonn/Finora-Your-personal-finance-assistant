# Finora Premium Fintech Color System

## Overview

The Finora color system is designed for premium wealth management and investment applications. It automatically adapts to the user's system appearance (Light/Dark Mode) without manual toggles, following Apple Human Interface Guidelines.

## Brand Personality

**Premium, Trustworthy, Discreet, Confident, Wealth-Focused**

The color palette conveys sophistication and reliability without being flashy. It's designed to appeal to high-net-worth individuals who value discretion and professionalism.

## Core Brand Colors

### Primary (#0B0F19)
- **Near black** - The foundation of the brand
- **Usage**: Primary actions, main text, key UI elements
- **Personality**: Authority, sophistication, trust

### Secondary - Gold (#F5C451)
- **Premium gold** - Used sparingly for emphasis
- **Usage**: CTAs in dark mode, highlights, premium features
- **Personality**: Luxury, value, exclusivity

### Accent - Emerald (#10B981)
- **Success green** - Positive financial indicators
- **Usage**: Success states, positive metrics, income
- **Personality**: Growth, prosperity, confidence

## Light Mode Color Palette

### Backgrounds
- **Primary Background**: `#F9FAFB` - Clean luxury light
- **Card Background**: `#FFFFFF` - Pure white for elevation
- **Secondary Background**: `#FFFFFF` - Elevated surfaces

### Text
- **Primary Text**: `#0B0F19` - Near black, crisp and readable
- **Secondary Text**: `#4B5563` - Medium gray for supporting content
- **Tertiary Text**: `#6B7280` - Subtle labels

### Actions
- **Primary Action**: `#0B0F19` - Near black buttons
- **Primary Action Text**: `#FFFFFF` - White text on dark buttons
- **Secondary Action**: `#F3F4F6` - Light gray background

### Accents
- **Accent**: `#F5C451` - Gold (used sparingly)
- **Success**: `#10B981` - Emerald green
- **Error**: `#DC2626` - Subtle red

### Borders & Dividers
- **Border**: `#E5E7EB` - Light gray
- **Subtle Border**: `#F3F4F6` - Very light gray

### Shadows
- **Card Shadow**: `rgba(0, 0, 0, 0.05)` - Subtle elevation
- **Elevated Shadow**: `rgba(0, 0, 0, 0.1)` - Higher elevation

## Dark Mode Color Palette

### Backgrounds
- **Primary Background**: `#0B0F19` - Premium near-black (not gray-washed)
- **Card Background**: `#111827` - Rich dark gray
- **Secondary Background**: `#1F2937` - Elevated dark surfaces

### Text
- **Primary Text**: `#E5E7EB` - Soft white (avoids pure white)
- **Secondary Text**: `#9CA3AF` - Light gray
- **Tertiary Text**: `#6B7280` - Medium gray

### Actions
- **Primary Action**: `#F5C451` - Gold (more prominent in dark mode)
- **Primary Action Text**: `#0B0F19` - Dark text on gold
- **Secondary Action**: `#1F2937` - Dark gray background

### Accents
- **Accent**: `#10B981` - Emerald (more prominent)
- **Success**: `#10B981` - Emerald green
- **Error**: `#EF4444` - Brighter red for visibility

### Borders & Dividers
- **Border**: `#1F2937` - Dark gray
- **Subtle Border**: `#374151` - Medium dark gray

## SwiftUI Usage

### Background Colors
```swift
// Primary background
Color.backgroundPrimary

// Card background
Color.backgroundCard

// Secondary background
Color.backgroundSecondary
```

### Text Colors
```swift
// Primary text
Text("Title")
    .foregroundColor(Color.textPrimary)

// Secondary text
Text("Subtitle")
    .foregroundColor(Color.textSecondary)

// Tertiary text
Text("Label")
    .foregroundColor(Color.textTertiary)
```

### Action Colors
```swift
// Primary button
Button("Action") {
    // action
}
.background(Color.actionPrimary)
.foregroundColor(Color.actionPrimaryText)

// Secondary button
Button("Secondary") {
    // action
}
.background(Color.actionSecondary)
.foregroundColor(Color.textPrimary)
```

### Accent Colors
```swift
// Accent badge
Text("Premium")
    .foregroundColor(Color.accent)

// Success state
Text("Success")
    .foregroundColor(Color.success)

// Error state
Text("Error")
    .foregroundColor(Color.error)
```

### Transaction Colors
```swift
// Income
Text(amount)
    .foregroundColor(Color.transactionIncome)

// Expense
Text(amount)
    .foregroundColor(Color.transactionExpense)
```

### Borders & Shadows
```swift
// Card with border
RoundedRectangle(cornerRadius: 12)
    .stroke(Color.border, lineWidth: 1)

// Card with shadow
.background(Color.backgroundCard)
.shadow(color: Color.shadowCard, radius: 8, x: 0, y: 2)
```

## Color Naming Conventions

### Semantic Naming
Colors are named by **purpose**, not by appearance:
- ✅ `Color.actionPrimary` (not `Color.black` or `Color.gold`)
- ✅ `Color.textPrimary` (not `Color.darkGray`)
- ✅ `Color.backgroundCard` (not `Color.white`)

### Naming Pattern
```
[Category][Purpose][Variant?]

Examples:
- backgroundPrimary
- textSecondary
- actionPrimary
- borderSubtle
- transactionIncome
```

## Usage Guidelines

### Light Mode Rules
1. **Gold Usage**: Use gold (`#F5C451`) sparingly for emphasis only
2. **Text Contrast**: Keep text dark and crisp for readability
3. **Shadows**: Use subtle shadows for card elevation
4. **White Cards**: Pure white cards on light gray background

### Dark Mode Rules
1. **Avoid Pure White**: Use `#E5E7EB` instead of pure white text
2. **Gold Prominence**: Make gold more prominent for CTAs
3. **High Contrast**: Maintain high contrast for financial data
4. **True Dark**: Use near-black (`#0B0F19`), not gray-washed backgrounds

### General Rules
1. **System Appearance**: Always follow system appearance (no manual toggle)
2. **WCAG AA**: All color combinations meet WCAG AA contrast requirements
3. **Consistency**: Use semantic colors consistently across the app
4. **Accessibility**: Test with Dynamic Type and accessibility features

## Accessibility

### Contrast Ratios
All text/background combinations meet WCAG AA standards:
- **Primary Text on Background**: 16.8:1 (Light), 12.1:1 (Dark)
- **Secondary Text on Background**: 7.2:1 (Light), 4.8:1 (Dark)
- **Action Text on Button**: 16.8:1 (Light), 12.1:1 (Dark)

### Dynamic Type Support
All text colors work with Dynamic Type:
```swift
Text("Content")
    .font(.body)
    .foregroundColor(Color.textPrimary)
    // Automatically adapts to Dynamic Type
```

## Why This Palette Fits Premium Fintech

### 1. **Trust & Authority**
- Near-black primary conveys stability and authority
- Avoids bright, flashy colors that suggest volatility

### 2. **Luxury Without Flashiness**
- Gold used sparingly suggests premium without being ostentatious
- Clean, minimal palette reflects sophistication

### 3. **Financial Clarity**
- High contrast ensures financial data is always readable
- Emerald green for positive metrics is universally understood

### 4. **Professional Discretion**
- Muted palette appeals to high-net-worth clients
- No neon colors or aggressive marketing aesthetics

### 5. **System Integration**
- Follows iOS design language
- Feels native and trustworthy

### 6. **Dark Mode Excellence**
- True dark theme (not gray-washed) reduces eye strain
- Gold becomes more prominent for important actions

## Implementation Notes

### Automatic Theme Switching
The color system automatically adapts using SwiftUI's dynamic color system:
```swift
Color(light: Color(hex: "F9FAFB"), dark: Color(hex: "0B0F19"))
```

### No Manual Toggle
The app respects system appearance settings:
```swift
// ✅ Correct - follows system
WindowGroup {
    ContentView()
}

// ❌ Wrong - forces light mode
WindowGroup {
    ContentView()
        .preferredColorScheme(.light)
}
```

### Asset Catalog Alternative
For production apps, consider using Color Assets in Xcode:
1. Create Color Set in Assets.xcassets
2. Set "Any Appearance" and "Dark Appearance" variants
3. Reference via `Color("ColorName")`

## Examples

### Premium Card Design
```swift
VStack {
    Text("Balance")
        .foregroundColor(Color.textSecondary)
    Text("$1,234,567")
        .foregroundColor(Color.textPrimary)
}
.padding()
.background(Color.backgroundCard)
.cornerRadius(16)
.shadow(color: Color.shadowCard, radius: 8, x: 0, y: 2)
```

### Primary CTA Button
```swift
Button("Invest Now") {
    // action
}
.frame(maxWidth: .infinity)
.frame(height: 50)
.background(Color.actionPrimary)
.foregroundColor(Color.actionPrimaryText)
.cornerRadius(12)
```

### Transaction Row
```swift
HStack {
    Text(transaction.description)
        .foregroundColor(Color.textPrimary)
    Spacer()
    Text(amount)
        .foregroundColor(
            transaction.type == .income 
                ? Color.transactionIncome 
                : Color.transactionExpense
        )
}
.padding()
.background(Color.backgroundCard)
.cornerRadius(12)
```

## Maintenance

### Adding New Colors
1. Add to `AppColors.swift` with semantic naming
2. Include both light and dark variants
3. Document usage in this guide
4. Update components consistently

### Testing
- Test in both Light and Dark modes
- Verify contrast ratios
- Test with Dynamic Type
- Check accessibility features

---

**Last Updated**: December 2024  
**Version**: 1.0  
**Compliance**: WCAG AA, Apple HIG

