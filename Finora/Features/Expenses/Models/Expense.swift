//
//  Expense.swift
//  Finora
//
//  Core expense data model for tracking user transactions
//  Supports both manual entry and receipt-scanned expenses
//

import Foundation

struct Expense: Identifiable, Codable, Hashable {
    let id: UUID
    var itemName: String
    var amount: Decimal
    var category: ExpenseCategory
    var quantity: Int
    var notes: String
    var date: Date
    var receiptImagePath: String?
    var isRecurring: Bool
    var createdAt: Date
    var updatedAt: Date

    // MARK: - Computed Properties

    var totalAmount: Decimal {
        amount * Decimal(quantity)
    }

    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: totalAmount as NSNumber) ?? "$0.00"
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }

    var isThisWeek: Bool {
        Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
    }

    var isThisMonth: Bool {
        Calendar.current.isDate(date, equalTo: Date(), toGranularity: .month)
    }

    // MARK: - Initialization

    init(
        id: UUID = UUID(),
        itemName: String,
        amount: Decimal,
        category: ExpenseCategory,
        quantity: Int = 1,
        notes: String = "",
        date: Date = Date(),
        receiptImagePath: String? = nil,
        isRecurring: Bool = false
    ) {
        self.id = id
        self.itemName = itemName
        self.amount = amount
        self.category = category
        self.quantity = quantity
        self.notes = notes
        self.date = date
        self.receiptImagePath = receiptImagePath
        self.isRecurring = isRecurring
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Expense, rhs: Expense) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Sample Data

extension Expense {
    static let samples: [Expense] = [
        Expense(
            itemName: "Whole Foods",
            amount: 87.50,
            category: .groceries,
            notes: "Weekly groceries"
        ),
        Expense(
            itemName: "Uber",
            amount: 24.00,
            category: .transportation,
            notes: "Trip to airport"
        ),
        Expense(
            itemName: "Netflix",
            amount: 15.99,
            category: .subscriptions,
            isRecurring: true
        ),
        Expense(
            itemName: "Coffee Shop",
            amount: 6.75,
            category: .dining
        )
    ]
}
