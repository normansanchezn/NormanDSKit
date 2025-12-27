//
//  DSChoiceChip.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

/// A selectable chip that toggles visual state based on selection.
///
/// `DSChoiceChip` renders a capsule-shaped control that highlights when selected
/// and invokes `onTap` when pressed. It adapts its colors using the design-system
/// theme and current color scheme.
///
/// ### Example
/// ```swift
/// DSChoiceChip(title: "iOS", isSelected: true) {
///     print("Selected iOS")
/// }
/// ```
///
/// - Parameters:
///   - title: The chip text.
///   - isSelected: Whether the chip is currently selected.
///   - onTap: Action invoked when the chip is tapped.
///
/// - Environment:
///   - dsTheme: Design system theme used for spacing, colors, and radii.
///   - colorScheme: The current color scheme (light/dark) used to resolve colors.
public struct DSChoiceChip: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let title: String
    private let isSelected: Bool
    private let onTap: () -> Void

    public init(
        title: String,
        isSelected: Bool,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            Text(title)
                .padding(.horizontal, theme.spacing.md)
                .padding(.vertical, theme.spacing.xs)
                .frame(minHeight: 32)
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .background(
            Capsule()
                .fill(backgroundColor)
        )
        .overlay(
            Capsule()
                .strokeBorder(borderColor, lineWidth: 1)
        )
        .foregroundColor(foregroundColor)
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }

    private var backgroundColor: Color {
        if isSelected {
            return theme.colors.primary.resolved(scheme).opacity(0.16)
        } else {
            return theme.colors.surface.resolved(scheme)
        }
    }

    private var borderColor: Color {
        if isSelected {
            return theme.colors.primary.resolved(scheme)
        } else {
            return theme.colors.primary.resolved(scheme)
        }
    }

    private var foregroundColor: Color {
        if isSelected {
            return theme.colors.primary.resolved(scheme)
        } else {
            return theme.colors.onBackground.resolved(scheme)
        }
    }
}
