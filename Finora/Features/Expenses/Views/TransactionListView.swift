//
//  TransactionListView.swift
//  Finora
//
//  Displays all expenses with filtering and sorting options
//  Supports swipe to delete and tap to edit
//

import SwiftUI

struct TransactionListView: View {

    // MARK: - Properties

    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel = TransactionListViewModel()
    @Environment(\.dismiss) private var dismiss

    // Animation States
    @State private var headerOpacity: Double = 0
    @State private var filterOpacity: Double = 0
    @State private var listOpacity: Double = 0

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.finoraBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                // Summary Header
                summaryHeader
                    .opacity(headerOpacity)

                // Filter Bar
                filterBar
                    .opacity(filterOpacity)
                    .padding(.top, 16)

                // Transaction List
                if viewModel.filteredExpenses.isEmpty {
                    emptyState
                        .opacity(listOpacity)
                } else {
                    transactionList
                        .opacity(listOpacity)
                }
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.large)
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: { viewModel.sortOrder = .dateDescending }) {
                        Label("Newest First", systemImage: viewModel.sortOrder == .dateDescending ? "checkmark" : "")
                    }
                    Button(action: { viewModel.sortOrder = .dateAscending }) {
                        Label("Oldest First", systemImage: viewModel.sortOrder == .dateAscending ? "checkmark" : "")
                    }
                    Button(action: { viewModel.sortOrder = .amountDescending }) {
                        Label("Highest Amount", systemImage: viewModel.sortOrder == .amountDescending ? "checkmark" : "")
                    }
                    Button(action: { viewModel.sortOrder = .amountAscending }) {
                        Label("Lowest Amount", systemImage: viewModel.sortOrder == .amountAscending ? "checkmark" : "")
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)
                }
            }
        }
        .onAppear {
            viewModel.loadExpenses()
            animateAppearance()
        }
        .sheet(item: $viewModel.expenseToEdit) { expense in
            EditExpenseView(expense: expense, onSave: { updatedExpense in
                viewModel.updateExpense(updatedExpense)
            }, onDelete: {
                viewModel.deleteExpense(expense)
            })
        }
    }

    // MARK: - Summary Header

    private var summaryHeader: some View {
        VStack(spacing: 16) {
            HStack(spacing: 24) {
                // Total Spent
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Spent")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)

                    Text(viewModel.totalSpentFormatted)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.finoraExpense)
                }

                Spacer()

                // Transaction Count
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Transactions")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.finoraTextSecondary)

                    Text("\(viewModel.filteredExpenses.count)")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.finoraTextPrimary)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
        }
    }

    // MARK: - Filter Bar

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                // All Filter
                filterChip(title: "All", isSelected: viewModel.selectedFilter == .all) {
                    viewModel.selectedFilter = .all
                }

                // Today
                filterChip(title: "Today", isSelected: viewModel.selectedFilter == .today) {
                    viewModel.selectedFilter = .today
                }

                // This Week
                filterChip(title: "This Week", isSelected: viewModel.selectedFilter == .thisWeek) {
                    viewModel.selectedFilter = .thisWeek
                }

                // This Month
                filterChip(title: "This Month", isSelected: viewModel.selectedFilter == .thisMonth) {
                    viewModel.selectedFilter = .thisMonth
                }

                Divider()
                    .frame(height: 24)
                    .padding(.horizontal, 4)

                // Category Filters
                ForEach(ExpenseCategory.allCases.prefix(6)) { category in
                    filterChip(
                        title: category.rawValue,
                        icon: category.icon,
                        color: category.color,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        if viewModel.selectedCategory == category {
                            viewModel.selectedCategory = nil
                        } else {
                            viewModel.selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }

    private func filterChip(
        title: String,
        icon: String? = nil,
        color: Color = .finoraAIAccent,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 12, weight: .medium))
                }

                Text(title)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(isSelected ? .white : .finoraTextSecondary)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? color : Color.finoraSurface)
            )
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.clear : Color.finoraBorder.opacity(0.3), lineWidth: 1)
            )
        }
    }

    // MARK: - Transaction List

    private var transactionList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.groupedExpenses.keys.sorted(by: >), id: \.self) { date in
                    Section {
                        ForEach(viewModel.groupedExpenses[date] ?? []) { expense in
                            transactionRow(expense)
                                .onTapGesture {
                                    viewModel.expenseToEdit = expense
                                }
                        }
                    } header: {
                        sectionHeader(for: date)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 100)
        }
    }

    private func sectionHeader(for date: Date) -> some View {
        HStack {
            Text(viewModel.formatSectionDate(date))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.finoraTextSecondary)

            Spacer()

            Text(viewModel.totalForDate(date))
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.finoraExpense)
        }
        .padding(.vertical, 8)
    }

    private func transactionRow(_ expense: Expense) -> some View {
        HStack(spacing: 14) {
            // Category Icon
            ZStack {
                Circle()
                    .fill(expense.category.color.opacity(0.12))
                    .frame(width: 48, height: 48)

                Image(systemName: expense.category.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(expense.category.color)
            }

            // Details
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.itemName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.finoraTextPrimary)
                    .lineLimit(1)

                Text(expense.category.rawValue)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
            }

            Spacer()

            // Amount and Time
            VStack(alignment: .trailing, spacing: 4) {
                Text(expense.formattedAmount)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.finoraExpense)

                Text(formatTime(expense.date))
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.finoraTextTertiary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.finoraSurface)
        )
        .contextMenu {
            Button(action: {
                viewModel.expenseToEdit = expense
            }) {
                Label("Edit", systemImage: "pencil")
            }

            Button(role: .destructive, action: {
                viewModel.deleteExpense(expense)
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 56, weight: .light))
                .foregroundColor(.finoraTextTertiary)

            VStack(spacing: 8) {
                Text("No Transactions")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.finoraTextPrimary)

                Text("Your expenses will appear here")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.finoraTextSecondary)
            }

            Spacer()
        }
    }

    // MARK: - Animations

    private func animateAppearance() {
        withAnimation(.easeInOut(duration: 0.5)) {
            headerOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
            filterOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: 0.5).delay(0.2)) {
            listOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        TransactionListView()
            .environmentObject(AppRouter())
    }
}
