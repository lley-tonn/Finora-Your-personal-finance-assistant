//
//  FilterChip.swift
//  Finora
//
//  Filter chip component
//

import SwiftUI

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(
                    isSelected 
                        ? Color.actionPrimaryText 
                        : Color.textPrimary
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    isSelected 
                        ? Color.actionPrimary 
                        : Color.actionSecondary
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            isSelected 
                                ? Color.clear 
                                : Color.border,
                            lineWidth: 1
                        )
                )
        }
    }
}

