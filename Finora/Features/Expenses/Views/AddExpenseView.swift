//
//  AddExpenseView.swift
//  Finora
//
//  Entry point for expense tracking
//  Mode selection: Quick Entry, Detailed Entry, Receipt Scan
//

import SwiftUI

struct AddExpenseView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @Environment(\.dismiss) private var dismiss

    // Animation States
    @State private var headerOpacity: Double = 0
    @State private var quickOpacity: Double = 0
    @State private var quickOffset: CGFloat = 20
    @State private var detailedOpacity: Double = 0
    @State private var detailedOffset: CGFloat = 20
    @State private var receiptOpacity: Double = 0
    @State private var receiptOffset: CGFloat = 20

    // Navigation State
    @State private var showQuickExpense = false
    @State private var showDetailedExpense = false
    @State private var showReceiptScanner = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.finoraBackground.ignoresSafeArea()

                VStack(spacing: 24) {
                    // Header
                    header
                        .opacity(headerOpacity)
                        .padding(.top, 32)

                    // Option Cards
                    VStack(spacing: 16) {
                        // Quick Entry
                        optionCard(
                            icon: "bolt.fill",
                            title: "Quick Entry",
                            subtitle: "Amount + Category",
                            description: "Log an expense in seconds",
                            color: .finoraAIAccent
                        ) {
                            showQuickExpense = true
                        }
                        .opacity(quickOpacity)
                        .offset(y: quickOffset)

                        // Detailed Entry
                        optionCard(
                            icon: "list.bullet.clipboard.fill",
                            title: "Detailed Entry",
                            subtitle: "Full expense details",
                            description: "Item, amount, notes & more",
                            color: .finoraSuccess
                        ) {
                            showDetailedExpense = true
                        }
                        .opacity(detailedOpacity)
                        .offset(y: detailedOffset)

                        // Receipt Scan
                        optionCard(
                            icon: "camera.fill",
                            title: "Scan Receipt",
                            subtitle: "Auto-extract from photo",
                            description: "Use camera or photo library",
                            color: .finoraSecurity
                        ) {
                            showReceiptScanner = true
                        }
                        .opacity(receiptOpacity)
                        .offset(y: receiptOffset)
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.finoraTextSecondary)
                    }
                }
            }
            .preferredColorScheme(.dark)
            .onAppear {
                animateAppearance()
            }
            .navigationDestination(isPresented: $showQuickExpense) {
                QuickExpenseView()
            }
            .navigationDestination(isPresented: $showDetailedExpense) {
                DetailedExpenseView()
            }
            .navigationDestination(isPresented: $showReceiptScanner) {
                ReceiptScannerView()
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 8) {
            Text("Add Expense")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.finoraTextPrimary)

            Text("Choose how you'd like to log your expense")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.finoraTextSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
    }

    // MARK: - Option Card

    private func optionCard(
        icon: String,
        title: String,
        subtitle: String,
        description: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(color.opacity(0.15))
                        .frame(width: 56, height: 56)

                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(color)
                }

                // Content
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.finoraTextPrimary)

                        Text(subtitle)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(color)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(
                                Capsule()
                                    .fill(color.opacity(0.15))
                            )
                    }

                    Text(description)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.finoraTextSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextTertiary)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.finoraSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.finoraBorder.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.6)) {
            headerOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.1)) {
            quickOpacity = 1.0
            quickOffset = 0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
            detailedOpacity = 1.0
            detailedOffset = 0
        }

        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            receiptOpacity = 1.0
            receiptOffset = 0
        }
    }
}

// MARK: - Preview

#Preview {
    AddExpenseView()
        .environmentObject(AppRouter())
}
