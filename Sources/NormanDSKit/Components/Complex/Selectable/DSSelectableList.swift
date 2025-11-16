//
//  DSSelectableList.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

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
