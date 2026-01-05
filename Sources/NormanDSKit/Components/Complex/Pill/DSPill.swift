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
        DSLabel(
            .init(
                text: text,
                style: DSLabelModel.Style.caption,
                textColor: .white
            )
        )
        .padding(.horizontal, theme.spacing.md)
        .padding(.vertical, theme.spacing.sm)
        .background(
            background
        )
    }

    private var background: some View {
        switch kind {
            case .neutral: return Capsule().fill(theme.colors.tertiary.resolved(scheme)).mcGlassEffectIfAvailable()
            case .success: return Capsule().fill(theme.colors.success.resolved(scheme)).mcGlassEffectIfAvailable()
            case .warning: return Capsule().fill(theme.colors.warning.resolved(scheme)).mcGlassEffectIfAvailable()
            case .error: return Capsule().fill(theme.colors.error.resolved(scheme)).mcGlassEffectIfAvailable()
        }
    }
}
