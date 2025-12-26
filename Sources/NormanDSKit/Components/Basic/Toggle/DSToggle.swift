//
//  DSToggle.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A design-system toggle that applies a custom `DSToggleStyle` and theme-aware visuals.
///
/// `DSToggle` wraps SwiftUI's `Toggle` and hides its label, providing a compact
/// switch-style control that integrates with the design system.
///
/// ### Example
/// ```swift
/// @State private var enabled = false
///
/// var body: some View {
///     DSToggle(isOn: $enabled)
/// }
/// ```
public struct DSToggle: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    @Binding private var isOn: Bool
    private let isVisible: Bool
    
    /// Creates a design-system toggle.
    /// - Parameters:
    ///   - isOn: A binding to a Boolean value that determines whether the toggle is on.
    ///   - isVisible: Whether the toggle is visible. Default is `true`.
    public init(
        isOn: Binding<Bool>,
        isVisible: Bool = true
    ) {
        self._isOn = isOn
        self.isVisible = isVisible
    }
    
    /// The content and layout of the toggle.
    public var body: some View {
        if isVisible {
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(
                    DSToggleStyle()
                )
        }
    }
}

