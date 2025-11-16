//
//  DSDialog.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

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
            
            // Imagen opcional (redondeada, estilo profile/banner)
            if let imageUrl, !imageUrl.isEmpty {
                roundedImage(urlString: imageUrl, size: 110)
                    .padding(.bottom, theme.spacing.xs)
            }
            
            // Título
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
            
            // Subtítulo
            if let subtitle, !subtitle.isEmpty {
                DSLabel(
                    DSLabelModel(
                        text: subtitle,
                        style: .body,
                        alignment: .center
                    )
                )
            }
            
            // Contenido extra inyectado (fields, labels, lo que quieras)
            content()
            
            // Botones
            HStack(spacing: theme.spacing.sm) {
                DSButton.tertiary(closeButtonTitle, isFullWidth: true, action: onClose)
                
                DSButton.primary(primaryButtonTitle, isFullWidth: true, action: onPrimaryAction)
            }
            .padding(.top, theme.spacing.sm)
            
        }
        .padding(theme.spacing.lg)
        .frame(maxWidth: 340)
        .background(
            // Liquid Glass: material + tint suave del DS
            RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                        .fill(
                            theme.colors.surface
                                .resolved(scheme)
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
