//
//  DSHeader.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

/// A theme-aware header with optional back/close buttons and trailing content.
///
/// `DSHeader` renders a compact or large title based on `DSHeaderModel.style`. It can
/// display back and close buttons and an optional trailing view (such as actions).
/// The header uses a liquid-glass background and adapts to the current color scheme
/// via the `dsTheme` environment.
///
/// `DSHeader` is a reusable, theme-aware header view that supports
/// back/close actions, an optional trailing area, and dynamic styling
/// (including a liquid-glass background) based on the current theme
/// and color scheme.
import SwiftUI

/// A themed header view with optional back/close buttons and trailing content.
///
/// `DSHeader` renders a compact or large title style (depending on the
/// provided `DSHeaderModel`), and can show a back button, a close button,
/// and a caller-provided trailing view (e.g. actions or status).
///
/// The header uses liquid-glass styling and adapts to the current
/// color scheme via the design system theme from the `dsTheme` environment.
///
/// - Generic parameter Trailing: The type of the trailing view content.
public struct DSHeader<Trailing: View>: View {
    
    /// The design system theme from the environment.
    @Environment(\.dsTheme) private var theme
    /// The current color scheme (light or dark).
    @Environment(\.colorScheme) private var scheme
    /// Action used to dismiss the current presentation.
    @Environment(\.dismiss) private var dismiss
    
    /// Header configuration (title, subtitle, style, and visibility of controls).
    private let model: DSHeaderModel
    /// Optional handler for the back action. Falls back to `dismiss()` when nil.
    private let onBack: (() -> Void)?
    /// Optional handler for the close action. Falls back to `dismiss()` when nil.
    private let onClose: (() -> Void)?
    /// Caller-provided trailing content (e.g., buttons). Empty when not provided.
    private let trailing: Trailing
    
    /// Creates a header with a trailing content view.
    ///
    /// - Parameters:
    ///   - model: Header configuration describing title, subtitle, style, and controls.
    ///   - onBack: Optional callback invoked when the back button is tapped.
    ///   - onClose: Optional callback invoked when the close button is tapped.
    ///   - trailing: A builder returning the trailing view shown on the right.
    public init(
        model: DSHeaderModel,
        onBack: (() -> Void)? = nil,
        onClose: (() -> Void)? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.model = model
        self.onBack = onBack
        self.onClose = onClose
        self.trailing = trailing()
    }
    
    /// Creates a header without trailing content.
    ///
    /// - Parameters:
    ///   - model: Header configuration describing title, subtitle, style, and controls.
    ///   - onBack: Optional callback invoked when the back button is tapped.
    ///   - onClose: Optional callback invoked when the close button is tapped.
    public init(
        model: DSHeaderModel,
        onBack: (() -> Void)? = nil,
        onClose: (() -> Void)? = nil
    ) where Trailing == EmptyView {
        self.model = model
        self.onBack = onBack
        self.onClose = onClose
        self.trailing = EmptyView()
    }
    
    /// The view hierarchy for the header.
    public var body: some View {
        ZStack {
            background
            content
        }
    }
    
    // MARK: - Background Liquid Glass
    
    /// The liquid-glass background, blending material with theme colors.
    private var background: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .background(
                    theme.colors.background
                        .resolved(scheme)
                        .opacity(theme.opacity.glassBackground)
                )
        }
        .ignoresSafeArea(edges: .top)
    }
    
    // MARK: - Content
    
    /// Header content layout including leading buttons, title block, and trailing area.
    private var content: some View {
        VStack(spacing: theme.spacing.xs) {
            HStack(spacing: theme.spacing.sm) {
                leadingButtons
                
                titleBlock
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                trailing
            }
            .padding(.horizontal, theme.spacing.lg)
            .padding(.top, theme.spacing.lg)
            .padding(.bottom, model.style == .large ? theme.spacing.xs : theme.spacing.sm)
            
            if model.style == .large {
                // Extra separador suave tipo Large Title
                Divider()
                    .opacity(theme.opacity.subtle)
                    .padding(.horizontal, theme.spacing.lg)
            }
        }
    }
    
    // MARK: - Leading
    
    /// Leading control area with optional back and close buttons.
    @ViewBuilder
    private var leadingButtons: some View {
        HStack(spacing: theme.spacing.xs) {
            if model.showsBackButton {
                Button(action: { onBack?() ?? dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(theme.colors.primary.resolved(scheme))
                        .padding(8)
                        .background(
                            Circle()
                                .fill(
                                    theme.colors.surface
                                        .resolved(scheme)
                                        .opacity(theme.opacity.glassBackground)
                                )
                        )
                }
            }
            
            if model.showsCloseButton {
                Button(action: { onClose?() ?? dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(theme.colors.textTitle.resolved(scheme))
                        .padding(8)
                        .background(
                            Circle()
                                .fill(
                                    theme.colors.surfaceSecondary
                                        .resolved(scheme)
                                        .opacity(theme.opacity.glassBackground)
                                )
                        )
                }
            }
        }
    }
    
    // MARK: - Title block
    
    /// Title and subtitle block, including an optional system image.
    @ViewBuilder
    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xs / 2) {
            HStack(spacing: theme.spacing.xs) {
                if let systemImage = model.systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(theme.colors.primary.resolved(scheme))
                }
                
                Text(model.title)
                    .font(
                        model.style == .large
                        ? theme.typography.h1.font
                        : theme.typography.title.font
                    )
                    .foregroundColor(
                        theme.typography.h1.color.resolved(scheme)
                    )
                    .lineLimit(1)
            }
            
            if let subtitle = model.subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(theme.typography.subtitle.font)
                    .foregroundColor(
                        theme.typography.subtitle.color.resolved(scheme)
                    )
                    .lineLimit(2)
            }
        }
    }
}

