//
//  DSInlineBanner.swift
//  NormanDSKit
//
//  Created by Norman on 28/12/25.
//

import SwiftUI

public struct DSInlineBanner: View {
    public enum Kind { case error, info, success }

    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let kind: Kind
    private let text: String

    public init(kind: Kind, text: String) {
        self.kind = kind
        self.text = text
    }

    public var body: some View {
        HStack(spacing: theme.spacing.sm) {
            Image(systemName: icon)
                .foregroundStyle(color)

            DSLabel(.init(
                text: text,
                style: .caption,
                textColor: color
            ))
        }
        .padding(theme.spacing.md)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.md)
                .fill(theme.colors.surfaceSecondary.resolved(scheme).opacity(0.75))
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radius.md)
                .stroke(color.opacity(0.25), lineWidth: 1)
        )
    }

    private var color: Color {
        switch kind {
        case .error: return theme.colors.error.resolved(scheme)
        case .success: return theme.colors.success.resolved(scheme)
        case .info: return theme.colors.primary.resolved(scheme)
        }
    }

    private var icon: String {
        switch kind {
        case .error: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.seal.fill"
        case .info: return "info.circle.fill"
        }
    }
}
