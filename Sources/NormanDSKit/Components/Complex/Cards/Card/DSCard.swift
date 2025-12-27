//
//  DSCard.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A design-system card with optional trailing content (e.g., toggle, actions).
///
/// `DSCard` displays a title, optional subtitle, and an optional avatar image.
/// You can also provide trailing content (like a toggle or buttons). When an
/// action is provided in the model, the entire card becomes tappable.
///
/// ### Example
/// ```swift
/// DSCard(model: DSCardModel(
///     title: DSLabelModel(text: "Norman Sanchez", style: .body),
///     subtitle: DSLabelModel(text: "iOS Engineer", style: .caption),
///     imageURL: "https://example.com/avatar.jpg",
///     imageSize: 72
/// ))
/// ```
public struct DSCard<Trailing: View>: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let model: DSCardModel
    private let trailing: Trailing
    
    /// Creates a card with optional trailing content.
    /// - Parameters:
    ///   - model: The configuration describing title, subtitle, image, and optional action.
    ///   - trailing: A builder for the trailing view (e.g., toggle, buttons).
    public init(
        model: DSCardModel,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.model = model
        self.trailing = trailing()
    }
    
    /// Creates a card without trailing content.
    /// - Parameter model: The configuration describing title, subtitle, image, and optional action.
    public init(model: DSCardModel) where Trailing == EmptyView {
        self.model = model
        self.trailing = EmptyView()
    }
    
    /// The content and layout of the card.
    public var body: some View {
        content
    }
    
    @ViewBuilder
    private var content: some View {
        let card = HStack(spacing: theme.spacing.md) {
            
            // Avatar opcional
            if let urlString = model.imageURL,
               !urlString.isEmpty {
                avatarView(urlString: urlString)
            }
            
            // Textos
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                DSLabel(model.title)
                
                if let subtitle = model.subtitle {
                    DSLabel(subtitle)
                }
            }
            
            Spacer(minLength: theme.spacing.md)
            
            // Trailing (toggle, icon, etc.)
            trailing
        }
        .padding(theme.spacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                .fill(theme.colors.primary.resolved(scheme))
                .shadow(
                    color: theme.colors.onBackground
                        .resolved(scheme)
                        .opacity(theme.opacity.elevatedSurface),
                    radius: 8,
                    y: 4
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                .stroke(
                    theme.colors.onBackground
                        .resolved(scheme)
                        .opacity(theme.opacity.subtle),
                    lineWidth: 0.5
                )
        )
        .padding(.horizontal, theme.spacing.xs)
        .padding(.vertical, theme.spacing.xs)
        
        if let action = model.action {
            card
                .contentShape(RoundedRectangle(cornerRadius: theme.radius.lg))
                .onTapGesture { action() }
        } else {
            card
        }
    }
    
    /// Renders the optional circular avatar image using `AsyncImage`.
    /// - Parameter urlString: The remote image URL string.
    /// - Returns: A circular avatar view with a subtle border.
    @ViewBuilder
    private func avatarView(urlString: String) -> some View {
        let size = model.imageSize ?? 56
        
        // Placeholder simple; tú aquí puedes luego meter un DSCircularImage
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Color.gray.opacity(0.2)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(
                    theme.colors.surface.resolved(scheme)
                        .opacity(theme.opacity.glassBorder),
                    lineWidth: 1
                )
        )
    }
}
