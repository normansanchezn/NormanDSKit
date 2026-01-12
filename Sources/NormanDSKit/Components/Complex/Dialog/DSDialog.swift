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
    private let primaryButtonTitle: String?
    private let closeButtonTitle: String
    private let onClose: (() -> Void)?
    private let onPrimaryAction: () -> Void
    private let content: () -> Content
    private let emojiType: EmojiType?
    
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        imageUrl: String? = nil,
        primaryButtonTitle: String?,
        closeButtonTitle: String = "Close",
        onClose: (() -> Void)? = nil,
        onPrimaryAction: @escaping () -> Void,
        emojiType: EmojiType? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
        self.primaryButtonTitle = primaryButtonTitle
        self.closeButtonTitle = closeButtonTitle
        self.onClose = onClose
        self.onPrimaryAction = onPrimaryAction
        self.emojiType = emojiType
        self.content = content
    }
    
    @ViewBuilder
    private func couldShowImageDialog(size: CGFloat = 60) -> some View {
        if emojiType != nil {
            Image(resolveEmojiImage(), bundle: .module)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .scaleEffect(1.15)
                .frame(width: size, height: size)
                .clipped()
                .accessibilityHidden(true)
        }
    }
    
    @ViewBuilder
    private func couldShowImage() -> some View {
        if let imageUrl, !imageUrl.isEmpty {
            roundedImage(urlString: imageUrl, size: 110)
                .padding(.bottom, theme.spacing.xs)
        }
    }
    
    @ViewBuilder
    private func couldShowTitle() -> some View {
        if let title, !title.isEmpty {
            DSLabel(
                DSLabelModel(
                    text: title,
                    style: .subtitle,
                    isBold: true,
                    alignment: .leading
                )
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    
    @ViewBuilder
    private func couldShowSubtitle() -> some View {
        if let subtitle, !subtitle.isEmpty {
            DSLabel(
                DSLabelModel(
                    text: subtitle,
                    style: .body,
                    alignment: .leading
                )
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func showButtonActions() -> some View {
        HStack(spacing: theme.spacing.sm) {
            if onClose != nil {
                DSButton.secondary(closeButtonTitle, isFullWidth: true, action: onClose!)
            }
            if primaryButtonTitle != nil {
                DSButton.primary(primaryButtonTitle!, isFullWidth: true, action: onPrimaryAction)
            }
        }
        .padding(.top, theme.spacing.sm)
    }
    
    public var body: some View {
        VStack {
            HStack(alignment: .center, spacing: theme.spacing.md) {
                couldShowImageDialog(size: 100)

                VStack(alignment: .leading, spacing: theme.spacing.xs) {
                    couldShowImage()
                    couldShowTitle()
                    couldShowSubtitle()
                    content()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .layoutPriority(1)
            }


            showButtonActions()
        }
        .padding(theme.spacing.md)
        .frame(maxWidth: 340)
        .background(backgroundView)
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
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
            .fill(.ultraThinMaterial)
            .background(
                RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                    .fill(
                        theme.colors.dialogBackgroundColor.resolved(scheme)
                            .opacity(theme.opacity.background)
                    )
            )
    }
    
    func resolveEmojiImage() -> String {
        switch emojiType {
            case .error: return "error_emoji"
            case .question: return "question_emoji"
            case .info: return "info_emoji"
            case .success: return "success_emoji"
            case .tip: return "tip_emoji"
            case .warning: return "warning_emoji"
            case .greatJob: return "great_job_emoji"
            case .cancel: return "cancel_emoji"
                default: return ""
        }
    }
    
    // MARK: - Rounded Image helper
    
    @ViewBuilder
    private func roundedImage(urlString: String, size: CGFloat) -> some View {
        if (urlString.isEmpty) {
            DSEmojiImageView(imgResName: "cancel_emoji", size: size, scale: 1.1)
                .setCircleAura(theme, scheme)
        } else {
            createSyncImage(urlString: urlString, size: size)
        }
    }
    
    @ViewBuilder
    private func createSyncImage(urlString: String, size: CGFloat) -> some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .empty:
                Image(resolveEmojiImage(), bundle: .module)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white.opacity(0.18), lineWidth: 1)
                    }
                    .background {
                        Circle()
                            .fill(Color.white.opacity(0.001))
                            .mcGlassEffectIfAvailable()
                    }
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                    .accessibilityHidden(true)
            case .failure( _):
                Image(resolveEmojiImage(), bundle: .module)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white.opacity(0.18), lineWidth: 1)
                    }
                    .background {
                        Circle()
                            .fill(Color.white.opacity(0.001))
                            .mcGlassEffectIfAvailable()
                    }
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                    .accessibilityHidden(true)
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

public enum EmojiType {
    case question
    case success
    case error
    case info
    case warning
    case tip
    case cancel
    case greatJob
}
