//
//  MentorConnectVerticalCarousel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 08/11/25.
//

import SwiftUI

import SwiftUI

public struct DSVerticalCarousel<Element, Content: View>: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
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
        VStack(alignment: .leading, spacing: theme.spacing.md) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, element in
                content(element)
            }
        }
        .padding(.vertical, theme.spacing.lg)
        .padding(.horizontal, theme.spacing.md)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.lg)
                .fill(
                    theme.colors.surface
                        .resolved(scheme)
                        .opacity(theme.opacity.glassBackground)
                )
        )
    }
}

#Preview {
    DSVerticalCarousel(items: [1, 2, 3, 4, 5]) { _ in
        Text("Hello")
    }
}
