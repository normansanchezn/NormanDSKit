//
//  DSVerticalGrid.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 12/11/25.
//

import SwiftUI

/// A generic vertical grid for laying out items using LazyVGrid.
///
/// `DSVerticalGrid` renders a configurable number of flexible columns and applies
/// design-system spacing. Provide your data array and a content builder to render
/// each element.
///
/// ### Example
/// ```swift
/// struct Skill: Identifiable { let id = UUID(); let name: String }
/// let skills = [Skill(name: "Swift"), Skill(name: "SwiftUI"), Skill(name: "Combine")]
///
/// DSVerticalGrid(items: skills, columns: 3) { skill in
///     Text(skill.name)
///         .font(.caption)
///         .padding(8)
///         .background(Capsule().fill(Color.blue.opacity(0.15)))
/// }
/// ```
public struct DSVerticalGrid<Element, Content: View>: View {
    
    /// The collection of items to display in the grid.
    private let items: [Element]
    /// A builder that produces a view for a given element.
    private let content: (Element) -> Content
    /// The computed grid column configuration.
    private let columns: [GridItem]
    /// The spacing between rows and columns.
    private let spacing: CGFloat
    
    /// Creates a vertical grid.
    /// - Parameters:
    ///   - items: The collection of items to display.
    ///   - columns: The number of flexible columns. Defaults to `3`.
    ///   - spacing: Optional spacing between items. Defaults to the design-system medium spacing.
    ///   - content: A builder that creates a view for each element.
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
    
    /// The content and layout of the vertical grid.
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

