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
        // MARK: - Brand
        primary: DSDynamicColor(
            light: Color(hex: "#007FFF"), // accent azul
            dark:  Color(hex: "#339DFF")  // un poco más brillante en dark
        ),
        secondary: DSDynamicColor(
            light: Color(hex: "#111827"), // gris-azulado oscuro (chips / tags)
            dark:  Color(hex: "#020F24")  // panel intermedio
        ),
        tertiary: DSDynamicColor(
            light: Color(hex: "#00C2FF"), // azul celeste / detalle
            dark:  Color(hex: "#4FD5FF")  // celeste brillante
        ),
        
        // MARK: - Backgrounds
        background: DSDynamicColor(
            light: Color(hex: "#F5F7FB"), // fondo casi blanco suave
            dark:  Color(hex: "#000A17")  // navy casi negro
        ),
        surface: DSDynamicColor(
            light: Color(hex: "#FFFFFF"), // cards claras
            dark:  Color(hex: "#020F24")  // cards/paneles sobre #000A17
        ),
        surfaceSecondary: DSDynamicColor(
            light: Color(hex: "#E4ECF7"), // contenedores secundarios
            dark:  Color(hex: "#062446")  // contenedores secundarios dark
        ),
        onBackground: DSDynamicColor(
            light: Color(hex: "#050816"), // texto principal en light
            dark:  Color(hex: "#F5F7FF")  // texto principal en dark
        ),
        
        // MARK: - Text
        textTitle: DSDynamicColor(
            light: Color(hex: "#050816"), // títulos en light
            dark:  Color(hex: "#F5F7FF")  // títulos en dark
        ),
        textSubtitle: DSDynamicColor(
            light: Color(hex: "#4B5563"), // subtítulos en light
            dark:  Color(hex: "#C7D2F5")  // subtítulos gris-azulado en dark
        ),
        textBody: DSDynamicColor(
            light: Color(hex: "#111827"), // cuerpo en light
            dark:  Color(hex: "#E5E7EB")  // cuerpo en dark
        ),
        textCaption: DSDynamicColor(
            light: Color(hex: "#6B7280"), // caption light
            dark:  Color(hex: "#9CA3AF")  // caption dark
        ),
        
        // MARK: - States (pueden quedarse como estaban, ya son buenos)
        success: DSDynamicColor(
            light: Color(hex: "#22C55E"),
            dark:  Color(hex: "#4ADE80")
        ),
        warning: DSDynamicColor(
            light: Color(hex: "#F59E0B"),
            dark:  Color(hex: "#FBBF24")
        ),
        error: DSDynamicColor(
            light: Color(hex: "#EF4444"),
            dark:  Color(hex: "#FCA5A5")
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
