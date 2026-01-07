//
//  DSButton.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A design-system button that adapts styling based on `DSButtonVariant` and theme.
///
/// `DSButton` renders as a glass-style button on supported OS versions and as a
/// themed legacy button otherwise. It supports full-width layout, optional SF
/// Symbols, and disabled state, all driven by `DSButtonModel`.
///
/// ### Example
/// ```swift
/// DSButton(
///     model: DSButtonModel(title: "Continue", systemImage: "arrow.right", variant: .primary)
/// ) {
///     // Handle tap
/// }
/// ```
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
    /// Creates a design-system button.
    ///
    /// - Parameters:
    ///   - model: The configuration describing content, variant, and sizing.
    ///   - action: The closure executed when the button is tapped.
    public init(
        model: DSButtonModel,
        action: @escaping () -> Void
    ) {
        self.model = model
        self.action = action
    }
    
    // MARK: - Body
    /// The content and layout for the button.
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
    /// The internal label view combining optional icon and title with spacing and sizing.
    private func createLabel(_ foregroundColor: Color) -> some View {
        HStack(spacing: theme.spacing.xs) {
            if let systemImage = model.systemImage, !systemImage.isEmpty {
                Image(systemName: systemImage)
            }

            DSLabel(
                .init(
                    text: model.title,
                    style: DSLabelModel.Style.body,
                    isBold: true,
                    textColor: foregroundColor
                )
            )
            .lineLimit(1)
        }
        .frame(maxWidth: model.isFullWidth ? .infinity : nil)
        .frame(minHeight: model.minHeight)
        .padding(.horizontal, theme.spacing.lg)
    }

    // MARK: - Button glass effect
    /// The glass-styled button for newer OS versions, varying by `variant`.
    @available(iOS 26.0, *)
    @ViewBuilder
    private var glassButton: some View {
        switch model.variant {
        case .primary:
            Button(action: action) { createLabel(foregroundColor) }
                .buttonStyle(.glassProminent)
                .tint(theme.colors.primary.resolved(scheme).opacity(model.isEnabled ? opacityDefaulButton : theme.opacity.disabled))

        case .secondary:
            Button(action: action) { createLabel(foregroundColor) }
                .buttonStyle(.glass)
                .tint(
                    theme.colors.primary.resolved(scheme)
                        .opacity(model.isEnabled ? opacityDefaulButton : theme.opacity.disabled))

        case .tertiary:
            Button(action: action) { createLabel(foregroundColor) }
                .buttonStyle(.plain)
                .foregroundStyle(theme.colors.primary.resolved(scheme).opacity(model.isEnabled ? opacityDefaulButton : theme.opacity.disabled))

        }
    }
    
    // MARK: - Legacy button
    /// The legacy-styled button for older OS versions with manual background/border.
    private var legacyButton: some View {
        Button(action: action) {
            createLabel(foregroundColor)
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
    /// The tint color used by glass button styles for each variant.
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
    /// The background shape and material used by the legacy/glass fallback.
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
    /// The background color for the legacy button by variant.
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
    /// The foreground (text/icon) color for the legacy button by variant.
    private var foregroundColor: Color {
        switch model.variant {
        case .primary:
            return .white
        case .secondary:
            return theme.colors.onPrimary.resolved(scheme)
        case .tertiary:
            return theme.colors.primary.resolved(scheme)
        }
    }
    
    // MARK: - Border color
    /// The border color for the legacy button by variant.
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
    /// The border width for the legacy button by variant.
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
    /// Creates a primary variant button with optional system image.
    /// - Parameters mirror `DSButtonModel` and an `action` closure.
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
    
    /// Creates a secondary variant button with optional system image.
    /// - Parameters mirror `DSButtonModel` and an `action` closure.
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
    
    /// Creates a tertiary variant button with optional system image.
    /// - Parameters mirror `DSButtonModel` and an `action` closure.
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
