//
//  MentorConnectVerticalCarousel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 08/11/25.
//

import SwiftUI

/// A vertical carousel container that stacks items with design-system spacing and styling.
///
/// `DSVerticalCarousel` renders a vertical list of views generated from the provided
/// `items` collection. It applies DS theme spacing and a subtle glass-like background.
///
/// - Generics:
///   - `Element`: The data type of each item in the carousel.
///   - `Content`: The SwiftUI view produced for each element.
///
/// ### Example
/// ```swift
/// DSVerticalCarousel(items: ["One", "Two", "Three"]) { item in
///     Text(item)
/// }
/// ```
///
/// - Parameters:
///   - items: The data source used to build each row of the carousel.
///   - content: A view builder that creates a `Content` view for each element.
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
