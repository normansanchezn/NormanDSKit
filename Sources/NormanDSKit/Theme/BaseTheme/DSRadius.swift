//
//  MCRadius.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 05/11/25.
//

import SwiftUI

// MARK: - DSRadius
public struct DSRadius: Sendable {
    public let none: CGFloat
    public let xs: CGFloat
    public let sm: CGFloat
    public let md: CGFloat
    public let lg: CGFloat
    public let xl: CGFloat
    public let full: CGFloat

    public init(
        none: CGFloat,
        xs: CGFloat,
        sm: CGFloat,
        md: CGFloat,
        lg: CGFloat,
        xl: CGFloat,
        full: CGFloat
    ) {
        self.none = none
        self.xs = xs
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
        self.full = full
    }
}

public extension DSRadius {
    static let `default` = DSRadius(
        none: 0,
        xs: 4,
        sm: 8,
        md: 12,
        lg: 16,
        xl: 24,
        full: 999
    )
}

