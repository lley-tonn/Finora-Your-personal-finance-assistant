//
//  CategoryPickerView.swift
//  Finora
//
//  Reusable category picker grid component
//  Displays expense categories in a tappable grid layout
//

import SwiftUI

struct CategoryPickerView: View {

    // MARK: - Properties

    @Binding var selectedCategory: ExpenseCategory
    var columns: Int = 4

    private let gridColumns: [GridItem]

    // MARK: - Initialization

    init(selectedCategory: Binding<ExpenseCategory>, columns: Int = 4) {
        self._selectedCategory = selectedCategory
        self.columns = columns
        self.gridColumns = Array(repeating: GridItem(.flexible(), spacing: 12), count: columns)
    }

    // MARK: - Body

    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: 12) {
            ForEach(ExpenseCategory.allCases) { category in
                categoryButton(category)
            }
        }
    }

    // MARK: - Category Button

    private func categoryButton(_ category: ExpenseCategory) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedCategory = category
            }
        }) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(
                            selectedCategory == category
                                ? category.color.opacity(0.2)
                                : Color.finoraSurface
                        )
                        .frame(width: 52, height: 52)

                    Image(systemName: category.icon)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(
                            selectedCategory == category
                                ? category.color
                                : .finoraTextSecondary
                        )
                }
                .overlay(
                    Circle()
                        .stroke(
                            selectedCategory == category
                                ? category.color
                                : Color.clear,
                            lineWidth: 2
                        )
                        .frame(width: 52, height: 52)
                )

                Text(category.rawValue)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(
                        selectedCategory == category
                            ? .finoraTextPrimary
                            : .finoraTextSecondary
                    )
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Compact Category Picker

struct CompactCategoryPickerView: View {

    @Binding var selectedCategory: ExpenseCategory
    @State private var showFullPicker = false

    var body: some View {
        Button(action: {
            showFullPicker = true
        }) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(selectedCategory.color.opacity(0.15))
                        .frame(width: 44, height: 44)

                    Image(systemName: selectedCategory.icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(selectedCategory.color)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Category")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.finoraTextTertiary)

                    Text(selectedCategory.rawValue)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.finoraTextPrimary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.finoraTextTertiary)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.finoraSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.finoraBorder.opacity(0.3), lineWidth: 1)
            )
        }
        .sheet(isPresented: $showFullPicker) {
            CategoryPickerSheet(selectedCategory: $selectedCategory)
        }
    }
}

// MARK: - Category Picker Sheet

struct CategoryPickerSheet: View {

    @Binding var selectedCategory: ExpenseCategory
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.finoraBackground.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        CategoryPickerView(selectedCategory: $selectedCategory, columns: 3)
                            .padding(.horizontal, 24)
                            .padding(.top, 16)
                    }
                }
            }
            .navigationTitle("Select Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.finoraAIAccent)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.finoraBackground.ignoresSafeArea()

        VStack(spacing: 24) {
            CategoryPickerView(selectedCategory: .constant(.groceries))
                .padding(.horizontal, 16)

            CompactCategoryPickerView(selectedCategory: .constant(.dining))
                .padding(.horizontal, 24)
        }
    }
    .preferredColorScheme(.dark)
}
