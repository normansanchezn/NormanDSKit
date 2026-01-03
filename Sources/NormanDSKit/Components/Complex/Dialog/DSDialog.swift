//
//  DSDialog.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A themed dialog card with optional image, title, subtitle, content, and actions.
///
/// `DSDialog` displays an optional rounded image, a title and subtitle, a caller
/// provided content area, and two actions (primary and close). It uses the
/// design-system theme and a liquid-glass background style.
///
/// ### Example
/// ```swift
/// DSDialog(
///     title: "Confirm",
///     subtitle: "This action cannot be undone.",
///     imageUrl: nil,
///     primaryButtonTitle: "OK",
///     onClose: { /* dismiss */ },
///     onPrimaryAction: { /* confirm */ }
/// ) {
///     Text("Are you sure?")
/// }
/// ```
///
/// - Parameters:
///   - title: Optional title shown at the top of the dialog.
///   - subtitle: Optional subtitle shown below the title.
///   - imageUrl: Optional image URL displayed as a rounded banner.
///   - primaryButtonTitle: Title for the primary action button.
///   - closeButtonTitle: Title for the close button. Defaults to "Close".
///   - onClose: Closure executed when the close button is tapped.
///   - onPrimaryAction: Closure executed when the primary button is tapped.
///   - content: A builder that provides additional content inside the dialog.
///
/// - Environment:
///   - dsTheme: Design system theme used for spacing, colors, and radii.
///   - colorScheme: The current color scheme (light/dark) used to resolve colors.
public struct DSDialog<Content: View>: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let title: String?
    private let subtitle: String?
    private let imageUrl: String?
    private let primaryButtonTitle: String
    private let closeButtonTitle: String
    private let onClose: () -> Void
    private let onPrimaryAction: () -> Void
    private let content: () -> Content
    
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        imageUrl: String? = nil,
        primaryButtonTitle: String,
        closeButtonTitle: String = "Close",
        onClose: @escaping () -> Void,
        onPrimaryAction: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
        self.primaryButtonTitle = primaryButtonTitle
        self.closeButtonTitle = closeButtonTitle
        self.onClose = onClose
        self.onPrimaryAction = onPrimaryAction
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: theme.spacing.md) {
            if let imageUrl, !imageUrl.isEmpty {
                roundedImage(urlString: imageUrl, size: 110)
                    .padding(.bottom, theme.spacing.xs)
            }
            if let title, !title.isEmpty {
                DSLabel(
                    DSLabelModel(
                        text: title,
                        style: .title,
                        isBold: true,
                        alignment: .center
                    )
                )
            }
            if let subtitle, !subtitle.isEmpty {
                DSLabel(
                    DSLabelModel(
                        text: subtitle,
                        style: .body,
                        alignment: .center
                    )
                )
            }
            
            content()
            HStack(spacing: theme.spacing.sm) {
                DSButton.tertiary(closeButtonTitle, isFullWidth: true, action: onClose)
                
                DSButton.primary(primaryButtonTitle, isFullWidth: true, action: onPrimaryAction)
            }
            .padding(.top, theme.spacing.sm)
            
        }
        .padding(theme.spacing.lg)
        .frame(maxWidth: 340)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                        .fill(
                            theme.colors.dialogBackgroundColor.resolved(scheme)
                                .opacity(theme.opacity.glassBackground)
                        )
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous))
        .shadow(
            color: theme.colors.onBackground
                .resolved(scheme)
                .opacity(theme.opacity.elevatedSurface),
            radius: 20,
            y: 8
        )
        .padding(theme.spacing.lg)
    }
    
    // MARK: - Rounded Image helper
    
    @ViewBuilder
    private func roundedImage(urlString: String, size: CGFloat) -> some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                theme.colors.surfaceSecondary
                    .resolved(scheme)
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous)
                .stroke(
                    theme.colors.onBackground
                        .resolved(scheme)
                        .opacity(theme.opacity.glassBorder),
                    lineWidth: 1
                )
        )
    }
}
