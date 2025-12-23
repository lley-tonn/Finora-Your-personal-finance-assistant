//
//  TransactionListView.swift
//  Finora
//
//  Transaction list screen view
//

import SwiftUI

struct TransactionListView: View {
    @StateObject private var viewModel = TransactionListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                // Balance Card
                BalanceCard(balance: viewModel.totalBalance)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                
                // Filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FilterChip(
                            title: "All",
                            isSelected: viewModel.selectedCategory == nil
                        ) {
                            viewModel.filterByCategory(nil)
                        }
                        
                        ForEach(TransactionCategory.allCases, id: \.self) { category in
                            FilterChip(
                                title: category.displayName,
                                isSelected: viewModel.selectedCategory == category
                            ) {
                                viewModel.filterByCategory(category)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 12)
                
                // Transaction List
                if viewModel.isLoading {
                    ProgressView()
                        .tint(Color.accent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.filteredTransactions.isEmpty {
                    EmptyStateView(
                        icon: "list.bullet.rectangle",
                        title: "No Transactions",
                        message: "Start adding transactions to track your finances"
                    )
                } else {
                    List(viewModel.filteredTransactions) { transaction in
                        TransactionRow(transaction: transaction)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .task {
                viewModel.loadTransactions()
            }
        }
    }
}

