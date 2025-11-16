//
//  MentorConnectVerticalGrid.swift
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
    
    public init(
        items: [Element],
        columns: Int = 3,
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.items = items
        self.content = content
        
        let spacingValue = spacing ?? DSSpacing.default.md
        
        self.columns = Array(
            repeating: GridItem(.flexible(), spacing: spacingValue),
            count: columns
        )
    }
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: theme.spacing.lg) {
                ForEach(Array(items.enumerated()), id: \.offset) { _, element in
                    content(element)
                }
            }
            .padding(.horizontal, theme.spacing.lg)
            .padding(.vertical, theme.spacing.lg)
        }
        .scrollClipDisabled()
    }
}

