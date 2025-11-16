//
//  DSGridVerticalSections.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSGridVerticalSections<
    SectionID: Hashable,
    Element: Identifiable,
    Content: View,
    SectionHeader: View
>: View {
    
    @Environment(\.dsTheme) private var theme
    
    private let groupedItems: [SectionID: [Element]]
    private let columns: [GridItem]
    private let content: (Element) -> Content
    private let sectionHeader: (SectionID) -> SectionHeader
    
    // MARK: - Init con header custom
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
        .scrollClipDisabled()
    }
    
    private var groupedKeys: [SectionID] {
        groupedItems
            .filter { !$0.value.isEmpty }
            .map { $0.key }
            .sorted { "\($0)" < "\($1)" }
    }
}
