//
//  DSMetricPill.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

public struct DSMetricPill: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let title: String
    private let subtitle: String
    private let systemImage: String

    public init(title: String, subtitle: String, systemImage: String) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
    }

    public var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: systemImage)
                    .foregroundStyle(theme.colors.primary.resolved(scheme))
                    .font(.caption)

                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(theme.colors.tertiary.resolved(scheme))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(theme.colors.textCaption.resolved(scheme))
                .lineLimit(1)
        }
        .padding(.horizontal, theme.spacing.xxxl)
        .padding(.vertical, theme.spacing.md)
        .mcGlassEffectIfAvailable()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(subtitle): \(title)")
    }
}
