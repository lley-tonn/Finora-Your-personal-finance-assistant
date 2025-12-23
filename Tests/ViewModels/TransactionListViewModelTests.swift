//
//  TransactionListViewModelTests.swift
//  FinoraTests
//
//  Unit tests for TransactionListViewModel
//

import XCTest
import Combine
@testable import Finora

@MainActor
final class TransactionListViewModelTests: XCTestCase {
    var viewModel: TransactionListViewModel!
    var mockNetworkClient: MockNetworkClient!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        viewModel = TransactionListViewModel(networkClient: mockNetworkClient)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockNetworkClient = nil
        super.tearDown()
    }
    
    func testLoadTransactions_Success() {
        // Given
        let expectation = expectation(description: "Transactions loaded")
        
        viewModel.$transactions
            .dropFirst()
            .sink { transactions in
                if !transactions.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        viewModel.loadTransactions()
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertFalse(viewModel.transactions.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFilterByCategory() {
        // Given
        viewModel.transactions = Transaction.mockTransactions
        let category = TransactionCategory.food
        
        // When
        viewModel.filterByCategory(category)
        
        // Then
        let filtered = viewModel.filteredTransactions
        XCTAssertTrue(filtered.allSatisfy { $0.category == category })
    }
    
    func testTotalBalance_Calculation() {
        // Given
        viewModel.transactions = Transaction.mockTransactions
        
        // When
        let totalBalance = viewModel.totalBalance
        
        // Then
        let expectedBalance = Transaction.mockTransactions.reduce(0) { total, transaction in
            total + (transaction.type == .income ? transaction.amount : -transaction.amount)
        }
        XCTAssertEqual(totalBalance, expectedBalance, accuracy: 0.01)
    }
}

