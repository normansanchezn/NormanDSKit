//
//  MentorConnectCarrousel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 08/11/25.
//

import SwiftUI

public struct DSHorizontalCarousel<Element, Content: View>: View {
    
    @Environment(\.dsTheme) private var theme
    
    private let items: [Element]
    private let content: (Element) -> Content
    
    public init(
        items: [Element],
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.items = items
        self.content = content
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: theme.spacing.md) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, element in
                    content(element)
                        .padding(.leading, index == 0 ? theme.spacing.lg : 0)
                        .padding(.trailing, index == items.count - 1 ? theme.spacing.lg : 0)
                }
            }
        }
        .scrollClipDisabled()   // ← importante para Liquid Glass
    }
}

