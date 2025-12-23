//
//  PreviewHelpers.swift
//  Finora
//
//  SwiftUI preview helpers
//

import SwiftUI

extension View {
    func previewWithAppState() -> some View {
        self.environmentObject(AppState())
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewWithAppState()
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
            .previewWithAppState()
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TransactionRow(transaction: Transaction.mockTransactions[0])
            TransactionRow(transaction: Transaction.mockTransactions[1])
        }
        .listStyle(.plain)
    }
}
#endif

