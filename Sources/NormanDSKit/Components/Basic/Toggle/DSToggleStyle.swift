//
//  DSToggleStyle.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A custom toggle style used by `DSToggle`, providing a themed track and thumb.
///
/// `DSToggleStyle` animates state changes with a spring, provides light haptic
/// feedback on tap, and resolves its colors from the design system theme.
public struct DSToggleStyle: ToggleStyle {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    /// Creates a new toggle style.
    public init() {}
    
    /// Creates the toggle's body.
    /// - Parameter configuration: The current toggle configuration (binding, label).
    /// - Returns: A view representing the styled toggle.
    public func makeBody(configuration: Configuration) -> some View {
        let isOn = configuration.isOn
        
        return Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                configuration.isOn.toggle()
            }
        } label: {
            ZStack(alignment: isOn ? .trailing : .leading) {
                // Track
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(trackColor(isOn: isOn))
                    .frame(width: 52, height: 32)
                    .shadow(
                        color: theme.colors.onBackground
                            .resolved(scheme)
                            .opacity(theme.opacity.subtle),
                        radius: 2,
                        y: 1
                    )
                
                // Thumb
                Circle()
                    .fill(
                        theme.colors.surface.resolved(scheme)
                    )
                    .frame(width: 28, height: 28)
                    .shadow(
                        color: .black.opacity(0.12),
                        radius: 1.5,
                        y: 1
                    )
                    .padding(.horizontal, 2)
            }
        }
        .buttonStyle(.plain)
    }
    
    /// Resolves the background track color based on the on/off state.
    /// - Parameter isOn: Whether the toggle is on.
    /// - Returns: The track color for the given state.
    private func trackColor(isOn: Bool) -> Color {
        if isOn {
            return theme.colors.primary
                .resolved(scheme)
                .opacity(0.95)
        } else {
            return theme.colors.surfaceSecondary
                .resolved(scheme)
                .opacity(0.9)
        }
    }
}

