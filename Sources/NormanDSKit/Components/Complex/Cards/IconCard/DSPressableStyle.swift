//
//  DSPressableStyle.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSPressableStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    public init(isPressed: Binding<Bool>) {
        self._isPressed = isPressed
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, newValue in
                isPressed = newValue
            }
    }
}
