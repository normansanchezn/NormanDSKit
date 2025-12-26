//
//  DSPrincipalHeader.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

public struct DSPrincipalHeader: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    public var dsPrincipalHeaderModel: DSPrincipalHeaderModel
    
    public init(dsPrincipalHeaderModel: DSPrincipalHeaderModel) {
        self.dsPrincipalHeaderModel = dsPrincipalHeaderModel
    }
    
    // MARK: - Body
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { proxy in
                let width = max(proxy.size.width, 200)
                DSRoundedImage(
                    .init(
                        imageURL: dsPrincipalHeaderModel.imageUrl,
                        size: width,
                        cornerRadius: 0,
                        showsGlassBackground: false
                    )
                )
                .frame(width: proxy.size.width, height: 280)
                .clipped()
                .clipShape(
                    RoundedCorner(radius: 40.0, corners: [.bottomLeft, .bottomRight])
                )
                .contentShape(Rectangle())
            }
            .frame(height: 280)
            
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(theme.colors.warning.resolved(scheme))
                        .font(.caption)
                    Text("4.6")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(theme.colors.textBody.resolved(scheme))
                    
                }
                .padding(.horizontal, theme.spacing.md)
                .padding(.vertical, theme.spacing.sm)
                .background(
                    Capsule()
                        .fill(
                            theme.colors.surface
                                .resolved(scheme)
                                .opacity(theme.opacity.glassBackground)
                        )
                )
                .padding(.vertical, theme.spacing.sm)
                
                DSLabel(
                    .init(
                        text: dsPrincipalHeaderModel.name,
                        style: .h2,
                        isBold: true
                    )
                )
                DSLabel(.init(text: dsPrincipalHeaderModel.jobTitle, style: .body))
                    .foregroundStyle(theme.colors.textCaption.resolved(scheme))
                    .padding(.trailing, theme.spacing.xl)
            }
            .padding(.leading, theme.spacing.xl)
            .padding(.bottom, theme.spacing.md)
            .background {
                RoundedRectangle(cornerRadius: 40.0)
                    .fill(
                        theme.colors.surfaceSecondary.resolved(scheme).opacity(theme.opacity.glassBorder)
                    )
            }
            .padding(.trailing, theme.spacing.xl)
        }
    }
}
