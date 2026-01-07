//
//  DSPrincipalHeader.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

/// A prominent hero-style header that showcases a background image and profile info.
///
/// `DSPrincipalHeader` renders a large, rounded hero image with a bottom-left overlay
/// containing rating and identity details (name and job title). It adapts to the
/// design-system theme and current color scheme.
///
/// ### Example
/// ```swift
/// DSPrincipalHeader(dsPrincipalHeaderModel: .init(
///     imageUrl: "https://example.com/photo.jpg",
///     name: "Norman",
///     lastName: "Sanchez",
///     email: "norman@example.com",
///     jobDescription: "Mentor & iOS Engineer",
///     jobTitle: "iOS Engineer",
///     jobType: "Full-time",
///     personalDescription: "Passionate about building great apps.",
///     skills: ["Swift", "SwiftUI", "Design Systems"]
/// ))
/// ```
///
/// - Parameters:
///   - dsPrincipalHeaderModel: The data model specifying the background image and profile fields.
///
/// - Environment:
///   - dsTheme: Design system theme used for spacing, colors, and radii.
///   - colorScheme: The current color scheme (light/dark) used to resolve colors.
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
            createRoundedImageBackground()
                .zIndex(0)
            
            createInformationContainer()
                .zIndex(1)
                .padding(.horizontal, theme.spacing.md)
        }
    }
    
    private func createInformationContainer() -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.xs) {
            createRankingView()
                .padding(.horizontal, theme.spacing.lg)
            
            DSLabel(
                .init(
                    text: dsPrincipalHeaderModel.name,
                    style: DSLabelModel.Style.h2,
                    isBold: true,
                    textColor: .white
                )
            )
            .padding(.horizontal, theme.spacing.lg)
            DSLabel(
                .init(
                    text: dsPrincipalHeaderModel.jobDescription,
                    style: DSLabelModel.Style.body,
                    textColor: .white
                )
            )
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, theme.spacing.lg)
        }
        .padding(.horizontal, theme.spacing.xl)
        .padding(.bottom, theme.spacing.md)
        .background { backgroundInformationView() }
        .padding(.trailing, theme.spacing.xl)
    }
    
    private func backgroundInformationView() -> some View {
        Capsule().fill(theme.colors.primary.resolved(scheme).opacity(theme.opacity.background))
        .mcGlassEffectIfAvailable()
    }
    
    private func createRoundedImageBackground() -> some View {
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
            .frame(width: proxy.size.width, height: 250)
            .clipped()
            .clipShape(
                RoundedCorner(radius: 100, corners: [.bottomLeft, .bottomRight])
            )
            .contentShape(Rectangle())
        }
        .frame(height: 250)
    }
    
    private func createRankingView() -> some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(theme.colors.warning.resolved(scheme))
                .font(.caption)
            DSLabel(
                .init(
                    text: dsPrincipalHeaderModel.rank ?? "N/A",
                    style: DSLabelModel.Style.caption,
                    textColor: theme.colors.h1.resolved(scheme)
                )
            )
                .font(.caption.weight(.semibold))
                .foregroundStyle(theme.colors.textBody.resolved(scheme))
            
        }
        .padding(.horizontal, theme.spacing.md)
        .padding(.vertical, theme.spacing.sm)
        .background(
            Capsule()
                .fill(theme.colors.surface.resolved(scheme).opacity(theme.opacity.background))
                .mcGlassEffectIfAvailable()
        )
        .padding(.vertical, theme.spacing.sm)
    }
}

