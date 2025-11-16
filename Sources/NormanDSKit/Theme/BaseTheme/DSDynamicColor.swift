//
//  DynamicColor.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 06/11/25.
//

import SwiftUI

// MARK: - Dynamic Color Wrapper
public struct DSDynamicColor: Sendable {
    public let light: Color
    public let dark: Color
    
    public init(light: Color, dark: Color) {
        self.light = light
        self.dark = dark
    }
    
    public func resolved(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? dark : light
    }
}
