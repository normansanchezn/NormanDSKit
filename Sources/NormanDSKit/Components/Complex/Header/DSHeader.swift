//
//  DSHeader.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSHeader<Trailing: View>: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    @Environment(\.dismiss) private var dismiss
    
    private let model: DSHeaderModel
    private let onBack: (() -> Void)?
    private let onClose: (() -> Void)?
    private let trailing: Trailing
    
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
    
    // Convenience cuando no hay trailing
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
    
    public var body: some View {
        ZStack {
            background
            content
        }
    }
    
    // MARK: - Background Liquid Glass
    
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
