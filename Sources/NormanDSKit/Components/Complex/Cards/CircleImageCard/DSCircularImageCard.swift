//
//  DSCircularImageCard.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A design-system card that displays a circular image with a name and description.
///
/// `DSCircularImageCard` renders an avatar using `DSCircularImage` and shows a
/// name and description in a lightweight glass-styled container.
///
/// ### Example
/// ```swift
/// DSCircularImageCard(
///     model: DSCircularImageCardModel(
///         imageURL: "https://example.com/avatar.jpg",
///         name: "Norman",
///         description: "iOS Engineer",
///         imageSize: 90
///     )
/// )
/// ```
public struct DSCircularImageCard: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let model: DSCircularImageCardModel
    
    /// Creates a circular image card.
    /// - Parameter model: The configuration describing the image URL, name, description, and size.
    public init(model: DSCircularImageCardModel) {
        self.model = model
    }
    
    /// The content and layout of the circular image card.
    public var body: some View {
        VStack(spacing: theme.spacing.md) {
            
            // Imagen circular (avatar / mentor)
            DSCircularImage(
                .init(
                    imageURL: model.imageURL,
                    size: model.imageSize,
                    showsBorder: true
                )
            )
            
            // Contenedor de texto con glass
            VStack(spacing: theme.spacing.xs) {
                DSLabel(
                    DSLabelModel(
                        text: model.name,
                        style: .body,
                        isBold: true,
                        alignment: .center
                    )
                )
                
                DSLabel(
                    DSLabelModel(
                        text: model.description,
                        style: .caption,
                        alignment: .center
                    )
                )
            }
            .padding(.vertical, theme.spacing.sm)
            .padding(.horizontal, theme.spacing.lg)
            .background(
                RoundedRectangle(cornerRadius: theme.radius.md)
                    .fill(
                        theme.colors.surface
                            .resolved(scheme)
                            .opacity(theme.opacity.glassBackground)
                    )
            )
        }
    }
}

