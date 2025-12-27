//
//  MentorConnectCarrousel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 08/11/25.
//

import SwiftUI

/// A horizontal carousel that lazily scrolls items with design-system spacing.
///
/// `DSHorizontalCarousel` displays a horizontally scrolling list of views generated
/// from the provided `items`. It adds leading/trailing padding to the first and
/// last items and disables scroll clipping for better glass effects.
///
/// - Generics:
///   - `Element`: The data type of each item in the carousel.
///   - `Content`: The SwiftUI view produced for each element.
///
/// ### Example
/// ```swift
/// DSHorizontalCarousel(items: Array(1...5)) { value in
///     Text("Item \(value)")
///         .padding(12)
///         .background(Capsule().fill(Color.blue.opacity(0.2)))
/// }
/// ```
///
/// - Parameters:
///   - items: The data source used to build each item in the carousel.
///   - content: A view builder that creates a `Content` view for each element.
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
        .applyScrollClipDisabledIfAvailable()
    }
}

