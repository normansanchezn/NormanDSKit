//
//  DSActionRow.swift
//  NormanDSKit
//
//  Created by Norman on 29/12/25.
//

import SwiftUI

public struct DSActionRow: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let title: DSLabelModel
    private let subtitle: DSLabelModel?
    private let systemImage: String
    private let onTap: @MainActor () -> Void

    public init(
        title: DSLabelModel,
        subtitle: DSLabelModel? = nil,
        systemImage: String,
        onTap: @escaping @MainActor () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.onTap = onTap
    }

    public var body: some View {
        Button {
            Task { @MainActor in onTap() }
        } label: {
            HStack(spacing: theme.spacing.md) {
                Image(systemName: systemImage)
                    .foregroundStyle(theme.colors.primary.resolved(scheme))
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: 4) {
                    DSLabel(title)
                    if let subtitle {
                        DSLabel(subtitle)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(theme.colors.textCaption.resolved(scheme))
            }
            .padding(theme.spacing.md)
            .background(
                RoundedRectangle(cornerRadius: theme.radius.lg)
                    .fill(theme.colors.surface.resolved(scheme).opacity(theme.opacity.glassBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.radius.lg)
                    .stroke(theme.colors.onBackground.resolved(scheme).opacity(theme.opacity.subtle), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityHint("Opens")
    }
}
