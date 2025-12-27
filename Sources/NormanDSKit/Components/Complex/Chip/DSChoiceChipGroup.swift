//
//  DSChoiceChipGroup.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

/// A horizontally scrolling group of `DSChoiceChip` items.
///
/// `DSChoiceChipGroup` displays a row of chips allowing a single selection. It
/// calls `onItemSelected` when the user selects a chip.
///
/// ### Example
/// ```swift
/// DSChoiceChipGroup(
///     items: ["Beginner", "Intermediate", "Advanced"],
///     selectedItem: "Intermediate",
///     onItemSelected: { print($0) }
/// )
/// ```
///
/// - Parameters:
///   - items: The list of chip titles.
///   - selectedItem: The currently selected chip title.
///   - onItemSelected: Callback invoked when a chip is selected.
///
/// - Environment:
///   - dsTheme: Design system theme used for spacing, colors, and radii.
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
            HStack(spacing: theme.spacing.xl) {
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

