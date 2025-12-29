//
//  DSRatingSelectableRow.swift
//  NormanDSKit
//
//  Created by Norman on 28/12/25.
//

import SwiftUI

public struct DSRatingSelectableRow: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let title: DSLabelModel
    private let subtitle: DSLabelModel?
    private let isSelected: Bool
    private let onTap: () -> Void

    public init(
        title: DSLabelModel,
        subtitle: DSLabelModel? = nil,
        isSelected: Bool,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.isSelected = isSelected
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            HStack(spacing: theme.spacing.md) {
                VStack(alignment: .leading, spacing: theme.spacing.xs) {
                    DSLabel(title)
                    if let subtitle { DSLabel(subtitle) }
                }

                Spacer(minLength: 0)

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(
                        isSelected
                        ? theme.colors.primary.resolved(scheme)
                        : theme.colors.textCaption.resolved(scheme)
                    )
            }
            .padding(theme.spacing.md)
            .background(
                RoundedRectangle(cornerRadius: theme.radius.md)
                    .fill(theme.colors.surfaceSecondary.resolved(scheme).opacity(0.7))
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.radius.md)
                    .stroke(
                        isSelected
                        ? theme.colors.primary.resolved(scheme).opacity(0.35)
                        : theme.colors.onBackground.resolved(scheme).opacity(theme.opacity.subtle),
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
