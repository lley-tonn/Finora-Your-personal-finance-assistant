//
//  TransactionListViewModel.swift
//  Finora
//
//  Transaction list screen ViewModel
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class TransactionListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var transactions: [Transaction] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedCategory: TransactionCategory?
    @Published var selectedType: TransactionType?
    
    // MARK: - Dependencies
    private let networkClient: NetworkClientProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    var filteredTransactions: [Transaction] {
        transactions.filter { transaction in
            let matchesCategory = selectedCategory == nil || transaction.category == selectedCategory
            let matchesType = selectedType == nil || transaction.type == selectedType
            return matchesCategory && matchesType
        }
    }
    
    var totalBalance: Double {
        transactions.reduce(0) { total, transaction in
            total + (transaction.type == .income ? transaction.amount : -transaction.amount)
        }
    }
    
    // MARK: - Initialization
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: - Public Methods
    func loadTransactions() {
        isLoading = true
        errorMessage = nil
        
        networkClient.request(FinoraEndpoint.getTransactions)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] (response: TransactionsResponse) in
                    self?.transactions = response.transactions
                }
            )
            .store(in: &cancellables)
    }
    
    func filterByCategory(_ category: TransactionCategory?) {
        selectedCategory = category
    }
    
    func filterByType(_ type: TransactionType?) {
        selectedType = type
    }
}

struct TransactionsResponse: Decodable {
    let transactions: [Transaction]
}

