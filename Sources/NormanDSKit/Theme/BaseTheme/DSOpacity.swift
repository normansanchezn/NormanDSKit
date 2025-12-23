//
//  DSOpacity.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 10/11/25.
//

// MARK: - DSOpacity
public struct DSOpacity: Sendable {
    public let disabled: Double
    public let pressed: Double
    public let overlay: Double
    public let glassBackground: Double
    public let glassBorder: Double
    public let elevatedSurface: Double
    public let focus: Double
    public let subtle: Double
    public let strong: Double
    public let tinted: Double
    
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
        tinted: Double
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
        disabled: 0.38,
        pressed: 0.12,
        overlay: 0.20,
        glassBackground: 0.14,
        glassBorder: 0.28,
        elevatedSurface: 0.08,
        focus: 0.24,
        subtle: 0.06,
        strong: 0.16,
        tinted: 0.12
    )
}
