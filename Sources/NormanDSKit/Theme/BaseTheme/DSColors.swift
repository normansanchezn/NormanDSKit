//
//  DSColors.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 05/11/25.
//

/// NormanDSKit Colors
///
/// This file defines the design system color tokens for NormanDSKit.
/// Use `DSColors` to access dynamic, light/dark-aware colors for brand,
/// decorative accents, backgrounds, text, and semantic states.

import SwiftUI

// MARK: - DS Colors
/// A collection of design-system color tokens.
///
/// `DSColors` groups dynamic colors used across the app, organized by
/// brand, decorative, background, text, and state categories.
/// Each color is represented by `DSDynamicColor`, which adapts to light
/// and dark appearances.
///
/// Use the `default` palette for a ready-to-use vibrant and professional look,
/// or create your own instance to customize the theme.
public struct DSColors: Sendable {
    /// Primary brand color used for key actions and highlights.
    public let primary: DSDynamicColor
    /// Secondary brand color used for tags, chips, or secondary emphasis.
    public let secondary: DSDynamicColor
    /// Tertiary accent color used for subtle accents and details.
    public let tertiary: DSDynamicColor
    
    /// Decorative accent color for illustrations and decorative elements.
    public let decorativeDoodle: DSDynamicColor
    
    /// App background color.
    public let background: DSDynamicColor
    /// Primary surface color for cards and containers.
    public let surface: DSDynamicColor
    /// Secondary surface color for nested or less prominent containers.
    public let surfaceSecondary: DSDynamicColor
    /// Foreground color used on top of the background (e.g., primary text).
    public let onBackground: DSDynamicColor
    
    /// Text color for titles.
    public let textTitle: DSDynamicColor
    /// Text color for subtitles.
    public let textSubtitle: DSDynamicColor
    /// Text color for body content.
    public let textBody: DSDynamicColor
    /// Text color for captions and metadata.
    public let textCaption: DSDynamicColor
    
    /// Semantic color indicating success.
    public let success: DSDynamicColor
    /// Semantic color indicating warnings.
    public let warning: DSDynamicColor
    /// Semantic color indicating errors.
    public let error: DSDynamicColor
    public let h1: DSDynamicColor
    public let h3: DSDynamicColor
    public let dialogBackgroundColor: DSDynamicColor
    public let onPrimary: DSDynamicColor
    public let boxBackground: DSDynamicColor
    public let onSecondary: DSDynamicColor
    public let onTextEntry: DSDynamicColor
    
    /// Creates a `DSColors` palette.
    ///
    /// - Parameters:
    ///   - primary: Primary brand color used for key actions and highlights.
    ///   - secondary: Secondary brand color used for tags, chips, or secondary emphasis.
    ///   - tertiary: Tertiary accent color used for subtle accents and details.
    ///   - decorativeDoodle: Decorative accent color for illustrations and decorative elements.
    ///   - background: App background color.
    ///   - surface: Primary surface color for cards and containers.
    ///   - surfaceSecondary: Secondary surface color for nested or less prominent containers.
    ///   - onBackground: Foreground color used on top of the background (e.g., primary text).
    ///   - textTitle: Text color for titles.
    ///   - textSubtitle: Text color for subtitles.
    ///   - textBody: Text color for body content.
    ///   - textCaption: Text color for captions and metadata.
    ///   - success: Semantic color indicating success.
    ///   - warning: Semantic color indicating warnings.
    ///   - error: Semantic color indicating errors.
    public init(
        primary: DSDynamicColor,
        secondary: DSDynamicColor,
        tertiary: DSDynamicColor,
        decorativeDoodle: DSDynamicColor,
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
        error: DSDynamicColor,
        h1: DSDynamicColor,
        h3: DSDynamicColor,
        dialogBackgroundColor: DSDynamicColor,
        onPrimary: DSDynamicColor,
        boxBackground: DSDynamicColor,
        onSecondary: DSDynamicColor,
        onTextEntry: DSDynamicColor
    ) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.decorativeDoodle = decorativeDoodle
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
        self.h1 = h1
        self.h3 = h3
        self.dialogBackgroundColor = dialogBackgroundColor
        self.onPrimary = onPrimary
        self.boxBackground = boxBackground
        self.onSecondary = onSecondary
        self.onTextEntry = onTextEntry
    }
}

// MARK: - Default Vibrant + Professional Palette
public extension DSColors {
    /// The default vibrant and professional color palette.
    ///
    /// This palette provides balanced contrast for light and dark modes,
    /// with brand-forward blues, clear surface hierarchy, and readable text colors.
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
        
        // MARK: - Decorative
        decorativeDoodle: DSDynamicColor(
            light: Color(hex: "#CFEAFF"),  // accent azul
            dark:  Color(hex: "#4FD5FF")   // tertiary dark (accent-like)
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
            light: Color(hex: "#757575"), // subtítulos en light
            dark:  Color(hex: "#C7D2F5")  // subtítulos gris-azulado en dark
        ),
        textBody: DSDynamicColor(
            light: Color(hex: "#050816"), // cuerpo en light
            dark:  Color(hex: "#edf3fa")  // cuerpo en dark
        ),
        textCaption: DSDynamicColor(
            light: Color(hex: "#bfd4ff"), // caption light
            dark:  Color(hex: "#9CA3AF")  // caption dark
        ),
        
        // MARK: - States
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
            dark:  Color(hex: "#EF4444")
        ),
        h1: DSDynamicColor(
            light: Color(hex: "#007FFF"),
            dark: Color(hex: "#339DFF")
        ),
        h3: DSDynamicColor(
            light: Color(hex: "#000000"),
            dark: Color(hex: "#FFFFFF")
        ),
        dialogBackgroundColor: DSDynamicColor(
            light: Color(hex: "#dee9ff"),
            dark: Color(hex: "#0046a1")
        ),
        onPrimary: DSDynamicColor(
            light: Color(hex: "#001f47"),
            dark: Color(hex: "#3895ff")
        ),
        boxBackground: DSDynamicColor(
            light: Color(hex: "62a1f5"),
            dark: Color(hex: "002547")
        ),
        onSecondary: DSDynamicColor(
            light: Color(hex:"72B0E8"),
            dark: Color(hex: "1991FF")
        ),
        onTextEntry: DSDynamicColor(
            light: Color(hex: "1991FF"),
            dark: Color(hex: "4CA7FC")
        )
    )
    
}

public extension Color {
    /// Creates a `Color` from a hexadecimal string.
    ///
    /// Accepts strings in the form `"#RRGGBB"` or `"RRGGBB"`.
    /// If the string can't be parsed, the resulting color defaults to black.
    ///
    /// - Parameter hex: A hex string representing the color components.
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
