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
    private let opacityDefaulButton: Double = 0.85
    private let opacityDefaultLegacyButton: Double = 1.0
    private let borderSizeDefault: Double = 0.9
    private let minHightDefault: CGFloat = 30
    
    // MARK: - Init
    public init(
        model: DSButtonModel,
        action: @escaping () -> Void
    ) {
        self.model = model
        self.action = action
    }
    
    // MARK: - Body
    public var body: some View {
        Group {
            if #available(iOS 26.0, *) {
                glassButton
            } else {
                legacyButton
            }
        }
        .disabled(!model.isEnabled)
    }

    // MARK: - Label
    private var label: some View {
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
    }

    // MARK: - Button glass effect
    @available(iOS 26.0, *)
    @ViewBuilder
    private var glassButton: some View {
        switch model.variant {
        case .primary:
            Button(action: action) { label }
                .buttonStyle(.glassProminent)
                .tint(
                    theme.colors.primary.resolved(scheme).opacity(model.isEnabled ? opacityDefaulButton : theme.opacity.disabled))

        case .secondary:
            Button(action: action) { label }
                .buttonStyle(.glass)
                .tint(
                    theme.colors.primary.resolved(scheme)
                        .opacity(model.isEnabled ? opacityDefaulButton : theme.opacity.disabled))

        case .tertiary:
            Button(action: action) { label }
                .buttonStyle(.plain)
                .foregroundStyle(theme.colors.primary.resolved(scheme).opacity(model.isEnabled ? opacityDefaulButton : theme.opacity.disabled))

        }
    }
    
    // MARK: - Legacy button
    private var legacyButton: some View {
        Button(action: action) {
            label
                .foregroundColor(foregroundColor)
                .background(
                    RoundedRectangle(cornerRadius: theme.radius.md)
                        .fill(backgroundColor)
                )
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radius.md)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .opacity(model.isEnabled ? opacityDefaultLegacyButton : theme.opacity.disabled)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Glass tint for variant
    @available(iOS 26.0, *)
    private var glassTintForVariant: Color {
        switch model.variant {
        case .primary:
            return theme.colors.primary.resolved(scheme)
        case .secondary, .tertiary:
            return theme.colors.primary.resolved(scheme)
        }
    }
    
    // MARK: - Background glass effect:
    @ViewBuilder
    private var backgroundView: some View {
        switch model.variant {
        case .primary:
            RoundedRectangle(cornerRadius: theme.radius.md)
                .fill(backgroundColor)

        case .secondary:
            RoundedRectangle(cornerRadius: theme.radius.md)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radius.md)
                        .fill(theme.colors.surface.resolved(scheme).opacity(theme.opacity.glassBackground))
                )

        case .tertiary:
            RoundedRectangle(cornerRadius: theme.radius.md)
                .fill(Color.clear)
        }
    }
    
    // MARK: - Colors
    private var backgroundColor: Color {
        switch model.variant {
        case .primary:
            return theme.colors.primary.resolved(scheme)
        case .secondary:
            return theme.colors.surface.resolved(scheme)
                .opacity(theme.opacity.glassBackground)
        case .tertiary:
            return .clear
        }
    }
    
    // MARK: - Foreground color
    private var foregroundColor: Color {
        switch model.variant {
        case .primary:
            return .white
        case .secondary, .tertiary:
            return theme.colors.primary.resolved(scheme)
        }
    }
    
    // MARK: - Border color
    private var borderColor: Color {
        switch model.variant {
        case .primary:
            return .clear
        case .secondary:
            return theme.colors.primary
                .resolved(scheme)
                .opacity(borderSizeDefault)
        case .tertiary:
            return .clear
        }
    }
    
    // MARK: - Border with
    private var borderWidth: CGFloat {
        switch model.variant {
        case .secondary:
            return 1
        default:
            return 0
        }
    }
}

// MARK: - Extension DSButton
public extension DSButton {
    static func primary(
        _ title: String,
        systemImage: String? = nil,
        isFullWidth: Bool = true,
        isEnabled: Bool = true,
        minHeight: CGFloat = 30,
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
        minHeight: CGFloat = 30,
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
        minHeight: CGFloat = 30,
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
