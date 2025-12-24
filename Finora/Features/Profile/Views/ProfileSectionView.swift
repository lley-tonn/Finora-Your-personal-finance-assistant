//
//  ProfileSectionView.swift
//  Finora
//
//  Reusable section container for profile groups
//  Groups related profile items with a title
//

import SwiftUI

struct ProfileSectionView: View {

    // MARK: - Properties

    let section: ProfileSection
    @ObservedObject var viewModel: ProfileViewModel
    let onItemTap: (ProfileDetailType) -> Void

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section Title
            Text(section.rawValue)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.finoraTextSecondary)
                .textCase(.uppercase)
                .padding(.horizontal, 4)

            // Section Items
            VStack(spacing: 8) {
                ForEach(section.items) { item in
                    ProfileRowView(
                        item: item,
                        viewModel: viewModel,
                        onTap: {
                            if case .detail(let type) = item.action {
                                onItemTap(type)
                            }
                        }
                    )
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ProfileSectionView(
        section: .security,
        viewModel: ProfileViewModel(),
        onItemTap: { _ in }
    )
    .padding()
    .background(Color.finoraBackground)
    .preferredColorScheme(.dark)
}
