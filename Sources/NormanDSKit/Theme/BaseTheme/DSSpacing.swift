//
//  DSSpacing.swift
//  DesignSystem
//
//  Created by Norman Sanchez on 15/11/25.
//

import SwiftUI

public struct DSSpacing {
    public let zero: CGFloat
    public let xs: CGFloat    // 4
    public let sm: CGFloat    // 8
    public let md: CGFloat    // 12
    public let lg: CGFloat    // 16
    public let xl: CGFloat    // 24
    public let xxl: CGFloat   // 32
    public let xxxl: CGFloat  // 40

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
