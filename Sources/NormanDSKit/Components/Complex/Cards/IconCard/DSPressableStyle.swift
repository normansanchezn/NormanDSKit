//
//  DSPressableStyle.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A lightweight `ButtonStyle` that exposes the pressed state via a `@Binding`.
///
/// `DSPressableStyle` observes `configuration.isPressed` and propagates it to the
/// provided binding so the caller can react visually (e.g., applying `scaleEffect`,
/// adjusting shadows, etc.).
///
/// ### Example
/// ```swift
/// struct Example: View {
///     @State private var isPressed = false
///
///     var body: some View {
///         Button("Tap me") { /* action */ }
///             .scaleEffect(isPressed ? 0.97 : 1)
///             .animation(.spring(response: 0.25, dampingFraction: 0.8), value: isPressed)
///             .buttonStyle(DSPressableStyle(isPressed: $isPressed))
///     }
/// }
/// ```
///
/// - Parameters:
///   - isPressed: A binding that receives the button's pressed state.
public struct DSPressableStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    /// Creates the button style and binds the pressed state.
    /// - Parameter isPressed: A binding that will be updated with the pressed state.
    public init(isPressed: Binding<Bool>) {
        self._isPressed = isPressed
    }
    
    /// Builds the content and keeps `configuration.isPressed` in sync with the external binding.
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { newValue in
                isPressed = newValue
            }
    }
}

