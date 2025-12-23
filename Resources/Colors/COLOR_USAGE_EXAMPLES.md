# Color System Usage Examples

## Quick Reference

### Background Colors
```swift
// Main screen background
ZStack {
    Color.backgroundPrimary
        .ignoresSafeArea()
    
    // Content
}

// Card background
.background(Color.backgroundCard)

// Elevated surface
.background(Color.backgroundSecondary)
```

### Text Colors
```swift
// Primary text (headings, important content)
Text("Balance")
    .foregroundColor(Color.textPrimary)

// Secondary text (subtitles, descriptions)
Text("Last updated today")
    .foregroundColor(Color.textSecondary)

// Tertiary text (labels, metadata)
Text("Category")
    .foregroundColor(Color.textTertiary)
```

### Button Colors
```swift
// Primary CTA button
Button("Invest Now") {
    // action
}
.background(Color.actionPrimary)
.foregroundColor(Color.actionPrimaryText)

// Secondary button
Button("Cancel") {
    // action
}
.background(Color.actionSecondary)
.foregroundColor(Color.textPrimary)
```

### Transaction Colors
```swift
// Income (positive)
Text("+$1,000")
    .foregroundColor(Color.transactionIncome)

// Expense (negative)
Text("-$500")
    .foregroundColor(Color.transactionExpense)
```

### Accent & Status Colors
```swift
// Premium badge
Text("Premium")
    .foregroundColor(Color.accent)

// Success message
Text("Transaction completed")
    .foregroundColor(Color.success)

// Error message
Text("Invalid input")
    .foregroundColor(Color.error)
```

### Borders & Shadows
```swift
// Card with border
.background(Color.backgroundCard)
.overlay(
    RoundedRectangle(cornerRadius: 12)
        .stroke(Color.border, lineWidth: 1)
)

// Card with shadow (light mode)
.background(Color.backgroundCard)
.shadow(color: Color.shadowCard, radius: 8, x: 0, y: 2)
```

## Complete Component Examples

### Premium Card
```swift
struct PremiumCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Total Assets")
                .font(.subheadline)
                .foregroundColor(Color.textSecondary)
            
            Text("$2,450,000")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color.backgroundCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.brandGold.opacity(0.2),
                            Color.brandEmerald.opacity(0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .shadow(color: Color.shadowCard, radius: 8, x: 0, y: 2)
    }
}
```

### Primary Button
```swift
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.actionPrimary)
                .foregroundColor(Color.actionPrimaryText)
                .cornerRadius(12)
        }
    }
}
```

### Transaction Row
```swift
struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon with gradient
            Image(systemName: "arrow.up.circle.fill")
                .foregroundColor(Color.actionPrimaryText)
                .frame(width: 44, height: 44)
                .background(
                    LinearGradient(
                        colors: [
                            Color.brandGold.opacity(0.8),
                            Color.brandEmerald.opacity(0.6)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.headline)
                    .foregroundColor(Color.textPrimary)
                
                Text(transaction.category)
                    .font(.caption)
                    .foregroundColor(Color.textSecondary)
            }
            
            Spacer()
            
            Text(transaction.amount)
                .font(.headline)
                .foregroundColor(
                    transaction.type == .income
                        ? Color.transactionIncome
                        : Color.transactionExpense
                )
        }
        .padding()
        .background(Color.backgroundCard)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.borderSubtle, lineWidth: 1)
        )
        .shadow(color: Color.shadowCard, radius: 4, x: 0, y: 1)
    }
}
```

### Filter Chip
```swift
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(
                    isSelected
                        ? Color.actionPrimaryText
                        : Color.textPrimary
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    isSelected
                        ? Color.actionPrimary
                        : Color.actionSecondary
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            isSelected
                                ? Color.clear
                                : Color.border,
                            lineWidth: 1
                        )
                )
        }
    }
}
```

### Text Field
```swift
struct CustomTextField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color.textSecondary)
            
            TextField("", text: $text)
                .foregroundColor(Color.textPrimary)
                .padding()
                .background(Color.actionSecondary)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.border, lineWidth: 1)
                )
        }
    }
}
```

## Best Practices

### ✅ Do
- Use semantic color names (`Color.textPrimary`, not `Color.black`)
- Always specify both light and dark variants
- Test in both appearance modes
- Use appropriate contrast ratios
- Follow the color usage guidelines

### ❌ Don't
- Use hardcoded colors (`Color(red: 0, green: 0, blue: 0)`)
- Force a specific appearance mode
- Mix system colors with brand colors inconsistently
- Use colors that don't meet WCAG AA standards
- Create manual theme toggles

## Testing Checklist

- [ ] Test all views in Light Mode
- [ ] Test all views in Dark Mode
- [ ] Verify contrast ratios meet WCAG AA
- [ ] Test with Dynamic Type enabled
- [ ] Verify colors adapt to system appearance
- [ ] Check accessibility features (VoiceOver, etc.)

