//
//  EmptyStateView.swift
//  Finora
//
//  Empty state component
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(Color.textTertiary)
            
            Text(title)
                .font(.headline)
                .foregroundColor(Color.textPrimary)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(Color.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

