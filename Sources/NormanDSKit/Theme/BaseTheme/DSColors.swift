//
//  DSColors.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 05/11/25.
//

import SwiftUI

// MARK: - DS Colors
public struct DSColors: Sendable {
    // Brand
    public let primary: DSDynamicColor
    public let secondary: DSDynamicColor
    public let tertiary: DSDynamicColor
    
    // Backgrounds
    public let background: DSDynamicColor
    public let surface: DSDynamicColor
    public let surfaceSecondary: DSDynamicColor
    public let onBackground: DSDynamicColor
    
    // Text
    public let textTitle: DSDynamicColor
    public let textSubtitle: DSDynamicColor
    public let textBody: DSDynamicColor
    public let textCaption: DSDynamicColor
    
    // States
    public let success: DSDynamicColor
    public let warning: DSDynamicColor
    public let error: DSDynamicColor
    
    public init(
        primary: DSDynamicColor,
        secondary: DSDynamicColor,
        tertiary: DSDynamicColor,
        background: DSDynamicColor,
        surface: DSDynamicColor,
        surfaceSecondary: DSDynamicColor,
        onBackground: DSDynamicColor,
        textTitle: DSDynamicColor,
        textSubtitle: DSDynamicColor,
        textBody: DSDynamicColor,
        textCaption: DSDynamicColor,
        success: DSDynamicColor,
        warning: DSDynamicColor,
        error: DSDynamicColor
    ) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.background = background
        self.surface = surface
        self.surfaceSecondary = surfaceSecondary
        self.onBackground = onBackground
        self.textTitle = textTitle
        self.textSubtitle = textSubtitle
        self.textBody = textBody
        self.textCaption = textCaption
        self.success = success
        self.warning = warning
        self.error = error
    }
}

// MARK: - Default Vibrant + Professional Palette
public extension DSColors {
    static let `default` = DSColors(
        // Brand
        primary: DSDynamicColor(
            light: Color(hex: "#0066FF"),
            dark: Color(hex: "#66AFFF")
        ),
        secondary: DSDynamicColor(
            light: Color(hex: "#7C3AED"),
            dark: Color(hex: "#C4A8FF")
        ),
        tertiary: DSDynamicColor(
            light: Color(hex: "#10D7AE"),
            dark: Color(hex: "#93F2DB")
        ),
        
        // Backgrounds
        background: DSDynamicColor(
            light: Color(hex: "#F8FAFC"),
            dark: Color(hex: "#020617")
        ),
        surface: DSDynamicColor(
            light: Color(hex: "#FFFFFF"),
            dark: Color(hex: "#020617")
        ),
        surfaceSecondary: DSDynamicColor(
            light: Color(hex: "#F1F5F9"),
            dark: Color(hex: "#111827")
        ),
        onBackground: DSDynamicColor(
            light: Color(hex: "#0F172A"),
            dark: Color(hex: "#E5E7EB")
        ),
        
        // Text
        textTitle: DSDynamicColor(
            light: Color(hex: "#0F172A"),
            dark: Color(hex: "#F9FAFB")
        ),
        textSubtitle: DSDynamicColor(
            light: Color(hex: "#4B5563"),
            dark: Color(hex: "#D1D5DB")
        ),
        textBody: DSDynamicColor(
            light: Color(hex: "#111827"),
            dark: Color(hex: "#E5E7EB")
        ),
        textCaption: DSDynamicColor(
            light: Color(hex: "#6B7280"),
            dark: Color(hex: "#9CA3AF")
        ),
        
        // States
        success: DSDynamicColor(
            light: Color(hex: "#22C55E"),
            dark: Color(hex: "#4ADE80")
        ),
        warning: DSDynamicColor(
            light: Color(hex: "#F59E0B"),
            dark: Color(hex: "#FBBF24")
        ),
        error: DSDynamicColor(
            light: Color(hex: "#EF4444"),
            dark: Color(hex: "#FCA5A5")
        )
    )
}

public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}
