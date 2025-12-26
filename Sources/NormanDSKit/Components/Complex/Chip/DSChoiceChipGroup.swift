//
//  DSChoiceChipGroup.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

public struct DSChoiceChipGroup: View {
    @Environment(\.dsTheme) private var theme

    private let items: [String]
    private let selectedItem: String?
    private let onItemSelected: (String) -> Void

    public init(
        items: [String],
        selectedItem: String?,
        onItemSelected: @escaping (String) -> Void
    ) {
        self.items = items
        self.selectedItem = selectedItem
        self.onItemSelected = onItemSelected
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: theme.spacing.xs) {
                ForEach(items, id: \.self) { item in
                    let isSelected = (item == selectedItem)
                    DSChoiceChip(
                        title: item,
                        isSelected: isSelected,
                        onTap: { onItemSelected(item) }
                    )
                }
            }
            .padding(.vertical, theme.spacing.xs)
        }
    }
}
