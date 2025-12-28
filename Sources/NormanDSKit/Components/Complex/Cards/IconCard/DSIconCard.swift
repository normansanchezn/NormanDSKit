//
//  DSIconCard.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// An action card from the design system that shows a system icon and a title.
///
/// `DSIconCard` renders a square button with a system image and a title below it.
/// When tapped, it triggers the action provided by the model and produces a light
/// haptic feedback.
///
/// The appearance (spacing, corner radius, colors, and shadows) comes from the
/// theme exposed in the environment (`dsTheme`) and adapts to the current
/// `colorScheme`.
///
/// ### Example
/// ```swift
/// let model = DSIconCardModel(
///     title: "Create task",
///     systemImage: "document.badge.plus",
///     size: .large
/// ) {
///     // Action to perform
/// }
///
/// DSIconCard(model: model)
/// ```
///
/// - Parameters:
///   - model: Configuration that defines the title, the SF Symbol (`systemImage`),
///     the card size, and the action to perform on tap.
///
/// - Environment:
///   - dsTheme: Design system theme used for colors, typography, spacing, and radii.
///   - colorScheme: The current color scheme (light/dark) used to resolve colors.
public struct DSIconCard: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    @State private var isPressed = false
    
    private let model: DSIconCardModel
    
    public init(model: DSIconCardModel) {
        self.model = model
    }
    
    private var side: CGFloat {
        switch model.size {
        case .small:  return 56
        case .medium: return 72
        case .large:  return 96
        }
    }
    
    public var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            model.action()
        } label: {
            VStack(spacing: theme.spacing.xs) {
                ZStack {
                    RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                        .fill(
                            model.backgroundColor
                                .opacity(theme.opacity.glassBackground)
                        )
                        .frame(width: side, height: side)
                        .shadow(
                            color: theme.colors.onBackground
                                .resolved(scheme)
                                .opacity(isPressed ? 0.08 : 0.16),
                            radius: isPressed ? 4 : 8,
                            y: isPressed ? 2 : 4
                        )
                    
                    Image(systemName: model.systemImage)
                        .font(.system(size: side * 0.38, weight: .medium))
                        .foregroundColor(
                            theme.colors.surface.resolved(scheme)
                        )
                }
                
                Text(model.title)
                    .font(theme.typography.caption.font)
                    .foregroundColor(
                        theme.colors.textTitle.resolved(scheme)
                    )
                    .lineLimit(1)
            }
            .scaleEffect(isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: isPressed)
        }
        .buttonStyle(DSPressableStyle(isPressed: $isPressed))
    }
}

