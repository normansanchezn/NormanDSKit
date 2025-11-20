//
//  MCTypography.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 05/11/25.
//
import SwiftUI


// MARK: - Typography
public struct DSTypography: Sendable {
    public struct TextStyle: Sendable {
        public let font: Font
        public let color: DSDynamicColor
        
        public init(font: Font, color: DSDynamicColor) {
            self.font = font
            self.color = color
        }
        
        public func resolvedColor(_ scheme: ColorScheme) -> Color {
            color.resolved(scheme)
        }
    }
    
    public let h1: TextStyle
    public let h2: TextStyle
    public let h3: TextStyle
    public let title: TextStyle
    public let subtitle: TextStyle
    public let body: TextStyle
    public let caption: TextStyle
    public let overline: TextStyle
    
    public init(
        h1: TextStyle,
        h2: TextStyle,
        h3: TextStyle,
        title: TextStyle,
        subtitle: TextStyle,
        body: TextStyle,
        caption: TextStyle,
        overline: TextStyle
    ) {
        self.h1 = h1
        self.h2 = h2
        self.h3 = h3
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.caption = caption
        self.overline = overline
    }
}

public extension DSTypography {
    static let `default`: DSTypography = {
        let colors = DSColors.default
        
        return DSTypography(
            h1: .init(
                font: .system(size: 32, weight: .bold, design: .default),
                color: colors.textTitle
            ),
            h2: .init(
                font: .system(size: 28, weight: .semibold, design: .default),
                color: colors.textTitle
            ),
            h3: .init(
                font: .system(size: 24, weight: .semibold, design: .default),
                color: colors.textTitle
            ),
            title: .init(
                font: .system(size: 20, weight: .semibold),
                color: colors.textTitle
            ),
            subtitle: .init(
                font: .system(size: 16, weight: .medium),
                color: colors.textSubtitle
            ),
            body: .init(
                font: .system(size: 16, weight: .regular),
                color: colors.textBody
            ),
            caption: .init(
                font: .system(size: 12, weight: .regular),
                color: colors.textCaption
            ),
            overline: .init(
                font: .system(size: 11, weight: .medium),
                color: colors.textCaption
            )
        )
    }()
}
