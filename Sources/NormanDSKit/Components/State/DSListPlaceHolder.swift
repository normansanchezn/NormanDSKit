//
//  DSListPlaceHolder.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import SwiftUI

public struct DSListPlaceHolder: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let rows: Int
    private let showsShimmer: Bool

    public init(rows: Int = 6, showsShimmer: Bool = true) {
        self.rows = rows
        self.showsShimmer = showsShimmer
    }

    public var body: some View {
        VStack(spacing: theme.spacing.md) {
            ForEach(0..<rows, id: \.self) { _ in
                placeholderRow
            }
        }
        .dsShimmer(showsShimmer)
        .accessibilityHidden(true)
    }

    private var placeholderRow: some View {
        HStack(spacing: theme.spacing.md) {
            Circle()
                .fill(skeletonColor)
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(skeletonColor)
                    .frame(height: 14)

                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(skeletonColor.opacity(0.85))
                    .frame(width: 160, height: 12)
            }

            Spacer()

            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(skeletonColor.opacity(0.9))
                .frame(width: 54, height: 20)
        }
        .padding(.horizontal, theme.spacing.lg)
        .padding(.vertical, theme.spacing.md)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                .fill(theme.colors.surface.resolved(scheme))
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                .stroke(theme.colors.surfaceSecondary.resolved(scheme).opacity(theme.opacity.subtle), lineWidth: 1)
        )
    }

    private var skeletonColor: Color {
        theme.colors.surfaceSecondary.resolved(scheme).opacity(0.55)
    }
}
