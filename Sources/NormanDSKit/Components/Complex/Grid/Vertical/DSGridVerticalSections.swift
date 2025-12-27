//
//  DSGridVerticalSections.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A sectioned vertical grid using `LazyVGrid` with support for custom or default section headers.
///
/// `DSGridVerticalSections` groups elements by a section identifier and renders them in a grid
/// layout with flexible columns. You can supply a custom header view per section, or use the
/// convenience initializer that generates a default `DSLabel` header from the section ID.
///
/// ### Example (custom header)
/// ```swift
/// struct Item: Identifiable { let id = UUID(); let title: String }
/// let data: [String: [Item]] = [
///     "iOS": [Item(title: "Swift"), Item(title: "SwiftUI")],
///     "Android": [Item(title: "Kotlin")]
/// ]
///
/// DSGridVerticalSections(
///     groupedItems: data,
///     columns: 3,
///     spacing: 8,
///     sectionHeader: { id in
///         HStack { Text(id).font(.headline); Spacer() }
///     },
///     content: { item in
///         Text(item.title)
///             .padding(8)
///             .background(Capsule().fill(Color.blue.opacity(0.15)))
///     }
/// )
/// ```
///
/// ### Example (default header)
/// ```swift
/// DSGridVerticalSections(groupedItems: data, columns: 2) { item in
///     Text(item.title)
/// }
/// ```
public struct DSGridVerticalSections<
    SectionID: Hashable,
    Element: Identifiable,
    Content: View,
    SectionHeader: View
>: View {
    
    @Environment(\.dsTheme) private var theme
    
    /// A dictionary mapping section identifiers to their elements.
    private let groupedItems: [SectionID: [Element]]
    
    /// The computed grid column configuration.
    private let columns: [GridItem]
    
    /// A builder that produces a view for each element.
    private let content: (Element) -> Content
    
    /// A builder that produces the section header view for a given section identifier.
    private let sectionHeader: (SectionID) -> SectionHeader
    
    // MARK: - Init con header custom
    
    /// Creates a sectioned vertical grid with a custom section header builder.
    /// - Parameters:
    ///   - groupedItems: A dictionary mapping section identifiers to arrays of elements.
    ///   - columns: The number of flexible columns. Defaults to `3`.
    ///   - spacing: Optional spacing between items. Defaults to the design-system medium spacing.
    ///   - sectionHeader: A builder for the section header view.
    ///   - content: A builder that creates a view for each element.
    public init(
        groupedItems: [SectionID: [Element]],
        columns: Int = 3,
        spacing: CGFloat? = nil,
        @ViewBuilder sectionHeader: @escaping (SectionID) -> SectionHeader,
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.groupedItems = groupedItems
        self.content = content
        self.sectionHeader = sectionHeader
        
        let spacingValue = spacing ?? DSSpacing.default.md
        
        self.columns = Array(
            repeating: GridItem(.flexible(), spacing: spacingValue),
            count: columns
        )
    }
    
    // MARK: - Init con header por default (DSLabel)
    
    /// Creates a sectioned vertical grid using a default text header (`DSLabel`).
    ///
    /// The section header text is derived from the section identifier's description.
    /// - Parameters:
    ///   - groupedItems: A dictionary mapping section identifiers to arrays of elements.
    ///   - columns: The number of flexible columns. Defaults to `3`.
    ///   - spacing: Optional spacing between items. Defaults to the design-system medium spacing.
    ///   - content: A builder that creates a view for each element.
    public init(
        groupedItems: [SectionID: [Element]],
        columns: Int = 3,
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping (Element) -> Content
    ) where SectionHeader == DSLabel, SectionID: CustomStringConvertible {
        
        self.groupedItems = groupedItems
        self.content = content
        
        let spacingValue = spacing ?? DSSpacing.default.md
        
        self.columns = Array(
            repeating: GridItem(.flexible(), spacing: spacingValue),
            count: columns
        )
        
        self.sectionHeader = { id in
            DSLabel(
                DSLabelModel(
                    text: id.description,
                    style: .title,
                    isBold: true
                )
            )
        }
    }
    
    /// The content and layout of the sectioned vertical grid.
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: theme.spacing.lg) {
                ForEach(groupedKeys, id: \.self) { sectionID in
                    Section(
                        header:
                            sectionHeader(sectionID)
                                .padding(.vertical, theme.spacing.sm)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    ) {
                        ForEach(groupedItems[sectionID] ?? []) { element in
                            content(element)
                        }
                    }
                }
            }
            .padding(.horizontal, theme.spacing.lg)
            .padding(.vertical, theme.spacing.lg)
        }
        .applyScrollClipDisabledIfAvailable()
    }
    
    /// The ordered list of non-empty section identifiers used to render sections.
    private var groupedKeys: [SectionID] {
        groupedItems
            .filter { !$0.value.isEmpty }
            .map { $0.key }
            .sorted { "\($0)" < "\($1)" }
    }
}

