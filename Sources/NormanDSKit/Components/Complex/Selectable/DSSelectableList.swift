//
//  DSSelectableList.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A vertical list of `DSSelectableRow` items that manages single selection.
///
/// `DSSelectableList` renders a column of selectable rows built from `DSSelectionItem`
/// models. Tapping a row toggles selection and updates the bound `selected` item.
///
/// ### Example
/// ```swift
/// @State private var selected: DSSelectionItem? = nil
/// let items: [DSSelectionItem] = [
///     .init(title: "iOS", icon: "iphone"),
///     .init(title: "Android", icon: "android.logo")
/// ]
///
/// DSSelectableList(selected: $selected, items: items)
/// ```
///
/// - Parameters:
///   - selected: Binding to the currently selected item.
///   - items: The list of items to display.
///
/// - Environment:
///   - dsTheme: Design system theme used for spacing and colors.
public struct DSSelectableList: View {
    
    @Environment(\.dsTheme) private var theme
    
    @Binding private var selected: DSSelectionItem?
    private let items: [DSSelectionItem]

    public init(
        selected: Binding<DSSelectionItem?>,
        items: [DSSelectionItem]
    ) {
        self._selected = selected
        self.items = items
    }

    public var body: some View {
        VStack(spacing: theme.spacing.md) {
            ForEach(items) { item in
                DSSelectableRow(
                    item: item,
                    isSelected: selected == item
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    selected = (selected == item) ? nil : item
                }
            }
        }
        .padding(.vertical, theme.spacing.md)
    }
}

