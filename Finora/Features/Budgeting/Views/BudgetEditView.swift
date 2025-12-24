//
//  BudgetEditView.swift
//  Finora - Edit budget categories and allocations
//

import SwiftUI

struct BudgetEditView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section("Monthly Income") {
                TextField("Amount", text: .constant("$4,000"))
            }

            Section("Categories") {
                ForEach(["Food", "Transport", "Shopping", "Bills"], id: \.self) { category in
                    HStack {
                        Text(category)
                        Spacer()
                        TextField("Amount", text: .constant("$500"))
                            .multilineTextAlignment(.trailing)
                    }
                }
            }

            Button("Save Changes") {
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Edit Budget")
    }
}
