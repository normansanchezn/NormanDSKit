//
//  DSSpacing.swift
//  DesignSystem
//
//  Created by Norman Sanchez on 15/11/25.
//

import SwiftUI

public struct DSSpacing: Sendable {
    public let zero: CGFloat
    public let xs: CGFloat
    public let sm: CGFloat
    public let md: CGFloat
    public let lg: CGFloat
    public let xl: CGFloat
    public let xxl: CGFloat
    public let xxxl: CGFloat

    public init(
        zero: CGFloat,
        xs: CGFloat,
        sm: CGFloat,
        md: CGFloat,
        lg: CGFloat,
        xl: CGFloat,
        xxl: CGFloat,
        xxxl: CGFloat
    ) {
        self.zero = zero
        self.xs = xs
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
        self.xxl = xxl
        self.xxxl = xxxl
    }
}

public extension DSSpacing {
    static let `default` = DSSpacing(
        zero: 0,
        xs: 4,
        sm: 8,
        md: 12,
        lg: 16,
        xl: 24,
        xxl: 32,
        xxxl: 40
    )
}
