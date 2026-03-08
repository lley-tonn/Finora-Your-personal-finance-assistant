//
//  ExpenseConfirmationView.swift
//  Finora
//
//  Success confirmation after saving an expense
//  Shows expense summary with options to add another or done
//

import SwiftUI

struct ExpenseConfirmationView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @Environment(\.dismiss) private var dismiss

    var expense: Expense?

    // Animation States
    @State private var checkmarkScale: CGFloat = 0
    @State private var checkmarkOpacity: Double = 0
    @State private var contentOpacity: Double = 0
    @State private var contentOffset: CGFloat = 30
    @State private var buttonsOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.finoraBackground.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // Success Animation
                successIcon
                    .scaleEffect(checkmarkScale)
                    .opacity(checkmarkOpacity)

                // Content
                VStack(spacing: 24) {
                    // Title
                    VStack(spacing: 8) {
                        Text("Expense Saved!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.finoraTextPrimary)

                        Text("Your expense has been logged successfully")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.finoraTextSecondary)
                    }

                    // Expense Summary
                    if let expense = expense {
                        expenseSummary(expense)
                    }
                }
                .opacity(contentOpacity)
                .offset(y: contentOffset)

                Spacer()

                // Action Buttons
                VStack(spacing: 12) {
                    // Add Another Button
                    Button(action: {
                        appRouter.navigate(to: .addExpense)
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "plus")
                                .font(.system(size: 15, weight: .semibold))

                            Text("Add Another")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.finoraAIAccent)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.finoraAIAccent, lineWidth: 2)
                        )
                    }

                    // Done Button
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    colors: [Color.finoraSuccess, Color.finoraSuccess.opacity(0.8)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                    }
                }
                .opacity(buttonsOpacity)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
        .navigationBarBackButtonHidden()
        .preferredColorScheme(.dark)
        .onAppear {
            animateAppearance()
        }
    }

    // MARK: - Success Icon

    private var successIcon: some View {
        ZStack {
            Circle()
                .fill(Color.finoraSuccess.opacity(0.15))
                .frame(width: 120, height: 120)

            Circle()
                .fill(Color.finoraSuccess.opacity(0.3))
                .frame(width: 90, height: 90)

            Circle()
                .fill(Color.finoraSuccess)
                .frame(width: 64, height: 64)

            Image(systemName: "checkmark")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
        }
    }

    // MARK: - Expense Summary

    private func expenseSummary(_ expense: Expense) -> some View {
        VStack(spacing: 16) {
            HStack(spacing: 14) {
                // Category Icon
                ZStack {
                    Circle()
                        .fill(expense.category.color.opacity(0.15))
                        .frame(width: 48, height: 48)

                    Image(systemName: expense.category.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(expense.category.color)
                }

                // Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(expense.itemName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.finoraTextPrimary)

                    Text(expense.category.rawValue)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.finoraTextSecondary)
                }

                Spacer()

                // Amount
                Text(expense.formattedAmount)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.finoraExpense)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.finoraSurface)
            )
        }
        .padding(.horizontal, 24)
    }

    // MARK: - Animations

    private func animateAppearance() {
        // Checkmark bounce animation
        withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.1)) {
            checkmarkScale = 1.0
            checkmarkOpacity = 1.0
        }

        // Content slide up
        withAnimation(.easeOut(duration: 0.5).delay(0.3)) {
            contentOpacity = 1.0
            contentOffset = 0
        }

        // Buttons fade in
        withAnimation(.easeOut(duration: 0.4).delay(0.5)) {
            buttonsOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    ExpenseConfirmationView(expense: Expense.samples.first)
        .environmentObject(AppRouter())
}
