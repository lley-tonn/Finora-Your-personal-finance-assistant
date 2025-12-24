//
//  PeerBenchmarkViewModel.swift
//  Finora
//

import Foundation

@MainActor
class PeerBenchmarkViewModel: ObservableObject {
    @Published var comparisons: [Comparison] = []

    func loadAnonymousComparisons() async {
        // TODO: Fetch privacy-preserving peer data
    }
}

struct Comparison {
    let metric: String
    let userValue: Double
    let peerAverage: Double
}
