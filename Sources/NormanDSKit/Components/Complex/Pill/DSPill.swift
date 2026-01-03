//
//  DSPill.swift
//  NormanDSKit
//
//  Created by Norman on 29/12/25.
//

import SwiftUI

public struct DSPill: View {
    public enum Kind { case neutral, success, warning, error }

    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let text: String
    private let kind: Kind

    public init(text: String, kind: Kind) {
        self.text = text
        self.kind = kind
    }

    public var body: some View {
        DSLabel(.init(
            text: text,
            style: .caption,
            textColor: foreground
        ))
        .padding(.horizontal, theme.spacing.sm)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.lg)
                .fill(background)
        )
    }

    private var background: Color {
        switch kind {
            case .neutral: return theme.colors.surface.resolved(scheme).opacity(0.9)
            case .success: return theme.colors.success.resolved(scheme).opacity(0.18)
            case .warning: return Color.orange.opacity(0.18)
            case .error: return theme.colors.error.resolved(scheme).opacity(0.18)
        }
    }

    private var foreground: Color {
        switch kind {
            case .neutral: return theme.colors.textCaption.resolved(scheme)
            case .success: return theme.colors.success.resolved(scheme)
            case .warning: return Color.orange
            case .error: return theme.colors.error.resolved(scheme)
        }
    }
}
