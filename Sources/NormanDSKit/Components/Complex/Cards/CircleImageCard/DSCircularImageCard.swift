//
//  DSCircularImageCard.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSCircularImageCard: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let model: DSCircularImageCardModel
    
    public init(model: DSCircularImageCardModel) {
        self.model = model
    }
    
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
