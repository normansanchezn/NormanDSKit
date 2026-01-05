//
//  DSPill.swift
//  NormanDSKit
//
//  Created by Norman on 29/12/25.
//

import SwiftUI

public struct DSPill: View {
    public enum Kind { case neutral, success, warning, error, iconOnly }

    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let text: String
    private let kind: Kind
    private let iconRes: String?

    public init(text: String, kind: Kind, iconRes: String? = nil) {
        self.text = text
        self.kind = kind
        self.iconRes = iconRes
    }

    public var body: some View {
        if iconRes != nil {
            Image(systemName: iconRes!)
                .frame(width: 14, height: 14)
                .foregroundColor(.white)
                .padding(theme.spacing.sm)
                .background(
                    background
                )
        } else {
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
    }

    private var background: some View {
        switch kind {
            case .neutral: return Capsule().fill(theme.colors.tertiary.resolved(scheme)).mcGlassEffectIfAvailable()
            case .success: return Capsule().fill(theme.colors.success.resolved(scheme)).mcGlassEffectIfAvailable()
            case .warning: return Capsule().fill(theme.colors.warning.resolved(scheme)).mcGlassEffectIfAvailable()
            case .error: return Capsule().fill(theme.colors.error.resolved(scheme)).mcGlassEffectIfAvailable()
            case .iconOnly: return Capsule().fill(theme.colors.primary.resolved(scheme)).mcGlassEffectIfAvailable()
        }
    }
}
