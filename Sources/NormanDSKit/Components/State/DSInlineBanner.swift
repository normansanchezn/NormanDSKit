//
//  DSInlineBanner.swift
//  NormanDSKit
//
//  Created by Norman on 28/12/25.
//

import SwiftUI

public struct DSInlineBanner: View {
    public enum Kind { case error, info, success, tap, swipe }

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
                .frame(width: 16, height: 16)
                .foregroundStyle(.white)

            DSLabel(
                .init(
                    text: text,
                    style: DSLabelModel.Style.caption,
                    textColor: .white
                )
            )
        }
        .padding(theme.spacing.md)
        .background(
            Capsule()
                .fill(color.opacity(theme.opacity.background))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(40)
        )
    }

    private var color: Color {
        switch kind {
        case .error: return theme.colors.error.resolved(scheme)
        case .success: return theme.colors.success.resolved(scheme)
        case .info: return theme.colors.primary.resolved(scheme)
        case .tap: return theme.colors.primary.resolved(scheme)
        case .swipe: return theme.colors.primary.resolved(scheme)
        }
    }

    private var icon: String {
        switch kind {
            case .error: return "exclamationmark.triangle.fill"
            case .success: return "checkmark.seal.fill"
            case .info: return "info.circle.fill"
            case .tap: return "hand.rays.fill"
            case .swipe: return "hand.draw.fill"
        }
    }
}
