//
//  DSOpacity.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 10/11/25.
//

// MARK: - DSOpacity
public struct DSOpacity {
    public let disabled: Double
    public let pressed: Double
    public let overlay: Double
    public let glassBackground: Double
    public let glassBorder: Double
    public let elevatedSurface: Double
    public let focus: Double
    public let subtle: Double
    public let strong: Double
    public let tinted: Double   // 👈 NUEVO
    
    public init(
        disabled: Double,
        pressed: Double,
        overlay: Double,
        glassBackground: Double,
        glassBorder: Double,
        elevatedSurface: Double,
        focus: Double,
        subtle: Double,
        strong: Double,
        tinted: Double           // 👈 NUEVO
    ) {
        self.disabled = disabled
        self.pressed = pressed
        self.overlay = overlay
        self.glassBackground = glassBackground
        self.glassBorder = glassBorder
        self.elevatedSurface = elevatedSurface
        self.focus = focus
        self.subtle = subtle
        self.strong = strong
        self.tinted = tinted
    }
}


public extension DSOpacity {
    static let `default` = DSOpacity(
        disabled: 0.38,           // Texto o elementos desactivados
        pressed: 0.12,            // Estados "isPressed"
        overlay: 0.20,            // Backdrops/blur overlays
        glassBackground: 0.15,    // Fondo de glass effect
        glassBorder: 0.30,        // Borde de cristal
        elevatedSurface: 0.06,    // Tarjetas elevadas
        focus: 0.24,              // Indicadores de foco
        subtle: 0.08,             // Líneas, hairlines, dividers suaves
        strong: 0.16,             // Dividers fuertes o strokes
        tinted: 0.12
    )
}
