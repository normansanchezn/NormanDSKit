//
//  ScaleButtonStyle.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 13/11/25.
//

import SwiftUI

public struct ScaleButtonStyle: ButtonStyle {
    
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

