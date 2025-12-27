//
//  DSLoader.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import SwiftUI

public struct DSLoader: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let title: String?

    public init(title: String? = nil) {
        self.title = title
    }

    public var body: some View {
        VStack(spacing: theme.spacing.md) {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(theme.colors.primary.resolved(scheme))

            if let title {
                Text(title)
                    .font(.body)
                    .foregroundStyle(theme.colors.textBody.resolved(scheme))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title ?? "Loading")
    }
}
