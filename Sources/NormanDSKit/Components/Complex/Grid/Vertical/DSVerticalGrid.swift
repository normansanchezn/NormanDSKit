//
//  DSVerticalGrid.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 12/11/25.
//

import SwiftUI

public struct DSVerticalGrid<Element, Content: View>: View {
    
    @Environment(\.dsTheme) private var theme
    
    private let items: [Element]
    private let content: (Element) -> Content
    private let columns: [GridItem]
    private let spacing: CGFloat
    
    public init(
        items: [Element],
        columns: Int = 3,
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.items = items
        self.content = content
        
        let spacingValue = spacing ?? DSSpacing.default.md
        self.spacing = spacingValue
        
        self.columns = Array(
            repeating: GridItem(.flexible(), spacing: spacingValue),
            count: columns
        )
    }
    
    public var body: some View {
        LazyVGrid(
            columns: columns,
            spacing: spacing
        ) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, element in
                content(element)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
