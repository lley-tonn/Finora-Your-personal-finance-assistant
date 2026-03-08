//
//  ScannedReceipt.swift
//  Finora
//
//  Data model for receipt scanning and OCR extraction
//  Holds captured image and extracted financial data
//

import Foundation
import UIKit

struct ScannedReceipt: Identifiable {
    let id: UUID
    let image: UIImage
    let capturedAt: Date
    var extractedData: ExtractedReceiptData?
    var processingStatus: ProcessingStatus

    init(
        id: UUID = UUID(),
        image: UIImage,
        capturedAt: Date = Date(),
        extractedData: ExtractedReceiptData? = nil,
        processingStatus: ProcessingStatus = .pending
    ) {
        self.id = id
        self.image = image
        self.capturedAt = capturedAt
        self.extractedData = extractedData
        self.processingStatus = processingStatus
    }

    enum ProcessingStatus: Equatable {
        case pending
        case processing
        case completed
        case failed(String)

        static func == (lhs: ProcessingStatus, rhs: ProcessingStatus) -> Bool {
            switch (lhs, rhs) {
            case (.pending, .pending): return true
            case (.processing, .processing): return true
            case (.completed, .completed): return true
            case (.failed(let a), .failed(let b)): return a == b
            default: return false
            }
        }
    }
}

// MARK: - Extracted Receipt Data

struct ExtractedReceiptData {
    var merchantName: String?
    var totalAmount: Decimal?
    var date: Date?
    var lineItems: [LineItem]
    var rawText: String
    var confidence: Double  // 0.0 to 1.0

    init(
        merchantName: String? = nil,
        totalAmount: Decimal? = nil,
        date: Date? = nil,
        lineItems: [LineItem] = [],
        rawText: String = "",
        confidence: Double = 0.0
    ) {
        self.merchantName = merchantName
        self.totalAmount = totalAmount
        self.date = date
        self.lineItems = lineItems
        self.rawText = rawText
        self.confidence = confidence
    }

    struct LineItem: Identifiable {
        let id = UUID()
        var description: String
        var amount: Decimal?
        var quantity: Int?

        init(description: String, amount: Decimal? = nil, quantity: Int? = nil) {
            self.description = description
            self.amount = amount
            self.quantity = quantity
        }
    }

    var formattedTotalAmount: String? {
        guard let total = totalAmount else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: total as NSNumber)
    }

    var confidencePercentage: Int {
        Int(confidence * 100)
    }

    var isHighConfidence: Bool {
        confidence >= 0.7
    }

    var suggestedCategory: ExpenseCategory {
        guard let merchant = merchantName?.lowercased() else { return .other }

        // Simple keyword matching for category suggestion
        if merchant.contains("grocery") || merchant.contains("whole foods") ||
           merchant.contains("trader") || merchant.contains("market") {
            return .groceries
        } else if merchant.contains("uber") || merchant.contains("lyft") ||
                  merchant.contains("taxi") || merchant.contains("gas") {
            return .transportation
        } else if merchant.contains("restaurant") || merchant.contains("cafe") ||
                  merchant.contains("coffee") || merchant.contains("starbucks") {
            return .dining
        } else if merchant.contains("amazon") || merchant.contains("target") ||
                  merchant.contains("walmart") {
            return .shopping
        } else if merchant.contains("netflix") || merchant.contains("spotify") ||
                  merchant.contains("apple") {
            return .subscriptions
        } else if merchant.contains("pharmacy") || merchant.contains("cvs") ||
                  merchant.contains("walgreens") {
            return .health
        }

        return .other
    }
}
