//
//  DSButton.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSButton: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let model: DSButtonModel
    private let action: () -> Void
    
    public init(
        model: DSButtonModel,
        action: @escaping () -> Void
    ) {
        self.model = model
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: theme.spacing.xs) {
                if let systemImage = model.systemImage, !systemImage.isEmpty {
                    Image(systemName: systemImage)
                }
                
                Text(model.title)
                    .font(theme.typography.body.font.weight(.semibold))
                    .lineLimit(1)
            }
            .frame(maxWidth: model.isFullWidth ? .infinity : nil)
            .frame(minHeight: model.minHeight)
            .padding(.horizontal, theme.spacing.lg)
            .foregroundColor(foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: theme.radius.md)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.radius.md)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .opacity(model.isEnabled ? 1.0 : theme.opacity.disabled)
        }
        .disabled(!model.isEnabled)
    }
    
    // MARK: - Colors
    
    private var backgroundColor: Color {
        switch model.variant {
        case .primary:
            return theme.colors.primary.resolved(scheme)
        case .secondary:
            // Surface con un toque de glass, estilo Liquid Glass
            return theme.colors.surface.resolved(scheme)
                .opacity(theme.opacity.glassBackground)
        case .tertiary:
            return .clear
        }
    }
    
    private var foregroundColor: Color {
        switch model.variant {
        case .primary:
            return .white
        case .secondary, .tertiary:
            return theme.colors.primary.resolved(scheme)
        }
    }
    
    private var borderColor: Color {
        switch model.variant {
        case .primary:
            return .clear
        case .secondary:
            return theme.colors.primary
                .resolved(scheme)
                .opacity(0.9)
        case .tertiary:
            return .clear
        }
    }
    
    private var borderWidth: CGFloat {
        switch model.variant {
        case .secondary:
            return 1
        default:
            return 0
        }
    }
}

public extension DSButton {
    static func primary(
        _ title: String,
        systemImage: String? = nil,
        isFullWidth: Bool = true,
        isEnabled: Bool = true,
        minHeight: CGFloat = 44,
        action: @escaping () -> Void
    ) -> DSButton {
        DSButton(
            model: DSButtonModel(
                title: title,
                systemImage: systemImage,
                variant: .primary,
                isFullWidth: isFullWidth,
                isEnabled: isEnabled,
                minHeight: minHeight
            ),
            action: action
        )
    }
    
    static func secondary(
        _ title: String,
        systemImage: String? = nil,
        isFullWidth: Bool = true,
        isEnabled: Bool = true,
        minHeight: CGFloat = 44,
        action: @escaping () -> Void
    ) -> DSButton {
        DSButton(
            model: DSButtonModel(
                title: title,
                systemImage: systemImage,
                variant: .secondary,
                isFullWidth: isFullWidth,
                isEnabled: isEnabled,
                minHeight: minHeight
            ),
            action: action
        )
    }
    
    static func tertiary(
        _ title: String,
        systemImage: String? = nil,
        isFullWidth: Bool = false,
        isEnabled: Bool = true,
        minHeight: CGFloat = 44,
        action: @escaping () -> Void
    ) -> DSButton {
        DSButton(
            model: DSButtonModel(
                title: title,
                systemImage: systemImage,
                variant: .tertiary,
                isFullWidth: isFullWidth,
                isEnabled: isEnabled,
                minHeight: minHeight
            ),
            action: action
        )
    }
}
