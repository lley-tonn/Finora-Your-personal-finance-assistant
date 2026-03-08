//
//  OCRService.swift
//  Finora
//
//  Vision framework text extraction for receipt scanning
//  Parses receipt text to extract financial data
//

import Vision
import UIKit

class OCRService {

    // MARK: - Singleton

    static let shared = OCRService()
    private init() {}

    // MARK: - Text Recognition

    func extractText(from image: UIImage) async throws -> ExtractedReceiptData {
        guard let cgImage = image.cgImage else {
            throw OCRError.invalidImage
        }

        return try await withCheckedThrowingContinuation { continuation in
            let request = VNRecognizeTextRequest { [weak self] request, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    continuation.resume(throwing: OCRError.noTextFound)
                    return
                }

                let extractedData = self?.parseReceiptText(from: observations) ?? ExtractedReceiptData()
                continuation.resume(returning: extractedData)
            }

            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true
            request.recognitionLanguages = ["en-US"]

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

            do {
                try handler.perform([request])
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    // MARK: - Receipt Parsing

    private func parseReceiptText(from observations: [VNRecognizedTextObservation]) -> ExtractedReceiptData {
        var allText = ""
        var lineItems: [ExtractedReceiptData.LineItem] = []
        var totalAmount: Decimal?
        var merchantName: String?
        var receiptDate: Date?

        // Sort observations by vertical position (top to bottom)
        let sortedObservations = observations.sorted {
            $0.boundingBox.origin.y > $1.boundingBox.origin.y
        }

        var lineIndex = 0

        for observation in sortedObservations {
            guard let candidate = observation.topCandidates(1).first else { continue }
            let text = candidate.string.trimmingCharacters(in: .whitespaces)
            allText += text + "\n"

            // Extract merchant (usually first meaningful line)
            if merchantName == nil && lineIndex < 3 && !text.isEmpty && text.count > 2 {
                let lowercased = text.lowercased()
                // Skip common non-merchant text
                if !containsDate(text) &&
                   !lowercased.contains("receipt") &&
                   !lowercased.contains("thank") &&
                   !lowercased.contains("welcome") {
                    merchantName = text
                }
            }

            // Extract total amount (look for total keywords)
            if let amount = extractTotalAmount(from: text) {
                totalAmount = amount
            }

            // Extract date
            if receiptDate == nil, let date = extractDate(from: text) {
                receiptDate = date
            }

            // Extract line items (price patterns)
            if let lineItem = extractLineItem(from: text) {
                lineItems.append(lineItem)
            }

            lineIndex += 1
        }

        // Calculate confidence based on what was found
        let confidence = calculateConfidence(
            totalFound: totalAmount != nil,
            merchantFound: merchantName != nil,
            dateFound: receiptDate != nil,
            itemsFound: !lineItems.isEmpty
        )

        return ExtractedReceiptData(
            merchantName: merchantName,
            totalAmount: totalAmount,
            date: receiptDate,
            lineItems: lineItems,
            rawText: allText,
            confidence: confidence
        )
    }

    // MARK: - Parsing Helpers

    private func extractTotalAmount(from text: String) -> Decimal? {
        let lowercased = text.lowercased()
        let totalKeywords = ["total", "amount due", "grand total", "sum", "balance", "subtotal"]

        // Check if this line contains a total keyword
        let containsTotalKeyword = totalKeywords.contains { keyword in
            lowercased.contains(keyword)
        }

        guard containsTotalKeyword else { return nil }

        // Extract currency amount from the line
        return extractAmount(from: text)
    }

    private func extractAmount(from text: String) -> Decimal? {
        // Match patterns like $XX.XX, XX.XX, $X,XXX.XX
        let patterns = [
            #"\$\s*[\d,]+\.?\d*"#,      // $amount
            #"[\d,]+\.\d{2}\s*$"#,       // amount at end of line
            #"[\d,]+\.\d{2}"#            // any decimal amount
        ]

        for pattern in patterns {
            guard let regex = try? NSRegularExpression(pattern: pattern) else { continue }
            let range = NSRange(text.startIndex..., in: text)

            if let match = regex.firstMatch(in: text, range: range),
               let matchRange = Range(match.range, in: text) {
                var amountString = String(text[matchRange])

                // Clean up the amount string
                amountString = amountString
                    .replacingOccurrences(of: "$", with: "")
                    .replacingOccurrences(of: ",", with: "")
                    .replacingOccurrences(of: " ", with: "")
                    .trimmingCharacters(in: .whitespaces)

                return Decimal(string: amountString)
            }
        }

        return nil
    }

    private func extractDate(from text: String) -> Date? {
        let dateFormats = [
            "MM/dd/yyyy",
            "MM-dd-yyyy",
            "MM/dd/yy",
            "MM-dd-yy",
            "yyyy-MM-dd",
            "MMM dd, yyyy",
            "MMMM dd, yyyy",
            "dd MMM yyyy"
        ]

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")

        // Try each format
        for format in dateFormats {
            dateFormatter.dateFormat = format

            // Try to find a date pattern in the text
            let datePatterns = [
                #"\d{1,2}[/-]\d{1,2}[/-]\d{2,4}"#,
                #"\d{4}[/-]\d{1,2}[/-]\d{1,2}"#,
                #"[A-Z][a-z]{2,8}\s+\d{1,2},?\s+\d{4}"#
            ]

            for pattern in datePatterns {
                guard let regex = try? NSRegularExpression(pattern: pattern) else { continue }
                let range = NSRange(text.startIndex..., in: text)

                if let match = regex.firstMatch(in: text, range: range),
                   let matchRange = Range(match.range, in: text) {
                    let dateString = String(text[matchRange])
                    if let date = dateFormatter.date(from: dateString) {
                        return date
                    }
                }
            }
        }

        return nil
    }

    private func extractLineItem(from text: String) -> ExtractedReceiptData.LineItem? {
        // Look for patterns like "Item Name    $XX.XX" or "Item Name    XX.XX"
        let pattern = #"^(.+?)\s{2,}(\$?\s*[\d,]+\.\d{2})$"#

        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let range = NSRange(text.startIndex..., in: text)

        guard let match = regex.firstMatch(in: text, range: range),
              match.numberOfRanges >= 3,
              let descRange = Range(match.range(at: 1), in: text),
              let amountRange = Range(match.range(at: 2), in: text) else {
            return nil
        }

        let description = String(text[descRange]).trimmingCharacters(in: .whitespaces)
        var amountString = String(text[amountRange])
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: .whitespaces)

        // Skip if description looks like a total or subtotal
        let lowercased = description.lowercased()
        if lowercased.contains("total") || lowercased.contains("subtotal") ||
           lowercased.contains("tax") || lowercased.contains("change") {
            return nil
        }

        guard let amount = Decimal(string: amountString) else { return nil }

        return ExtractedReceiptData.LineItem(
            description: description,
            amount: amount,
            quantity: 1
        )
    }

    private func containsDate(_ text: String) -> Bool {
        let datePattern = #"\d{1,2}[/-]\d{1,2}[/-]\d{2,4}"#
        return text.range(of: datePattern, options: .regularExpression) != nil
    }

    private func calculateConfidence(totalFound: Bool, merchantFound: Bool, dateFound: Bool, itemsFound: Bool) -> Double {
        var confidence = 0.3  // Base confidence for recognizing text

        if totalFound { confidence += 0.3 }
        if merchantFound { confidence += 0.2 }
        if dateFound { confidence += 0.1 }
        if itemsFound { confidence += 0.1 }

        return min(confidence, 1.0)
    }

    // MARK: - Error Types

    enum OCRError: LocalizedError {
        case invalidImage
        case noTextFound
        case parsingFailed

        var errorDescription: String? {
            switch self {
            case .invalidImage:
                return "Invalid image format. Please try again."
            case .noTextFound:
                return "No text found in the image. Please ensure the receipt is clearly visible."
            case .parsingFailed:
                return "Failed to parse receipt data. Please enter details manually."
            }
        }
    }
}
