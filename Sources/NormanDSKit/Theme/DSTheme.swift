//
//  DefaultTheme.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 05/11/25.
//

import SwiftUI

// MARK: - DSTheme
public struct DSTheme {
    public let colors: DSColors
    public let typography: DSTypography
    public let opacity: DSOpacity
    public let radius: DSRadius
    public let spacing: DSSpacing

    public init(
        colors: DSColors = .default,
        typography: DSTypography = .default,
        opacity: DSOpacity = .default,
        radius: DSRadius = .default,
        spacing: DSSpacing = .default
    ) {
        self.colors = colors
        self.typography = typography
        self.opacity = opacity
        self.radius = radius
        self.spacing = spacing
    }
}


