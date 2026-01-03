//
//  DSStatusPill.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import SwiftUI

/// A theme‑aware status pill that displays a short label with a colored background.
///
/// ``DSStatusPill`` renders a compact, rounded capsule with text and a background
/// color that reflects the provided ``DSStatus``. Use it to indicate progress or
/// state such as pending, started, in‑process, or completed.
///
/// The component adapts to your design system via ``EnvironmentValues/dsTheme`` and
/// the current ``SwiftUI/ColorScheme``.
///
/// ### Example
/// ```swift
/// DSStatusPill(text: "In Process", status: .inProcess)
/// DSStatusPill(text: "Completed", status: .completed)
/// DSStatusPill(text: "General") // defaults to primary color when status is nil
/// ```
///
/// - SeeAlso: ``DSStatus``, ``EnvironmentValues/dsTheme``
public struct DSStatusPill: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    /// The text displayed inside the pill.
    ///
    /// Keep this short (typically 1–2 words) to maintain the pill's compact appearance.
    let text: String
    
    /// The optional status that determines the pill's background color.
    ///
    /// When `nil`, the pill uses the theme's primary color. When non‑`nil`, the color
    /// maps to the corresponding ``DSStatus`` case (for example, ``DSStatus/completed``,
    /// ``DSStatus/inProcess``, ``DSStatus/started``, ``DSStatus/pending``).
    let status: DSStatus?
    
    /// Creates a status pill.
    ///
    /// - Parameters:
    ///   - text: The label to display inside the pill.
    ///   - status: An optional ``DSStatus`` to control the background color. Pass `nil`
    ///             to use the theme's primary color.
    public init(
        text: String,
        status: DSStatus? = nil
    ) {
        self.text = text
        self.status = status
    }
    
    
    @ViewBuilder
    private var backgroundCapsule: some View {
        switch status {
        case .completed:
            Capsule().fill(theme.colors.success.resolved(scheme))
        case .inProcess:
            Capsule().fill(theme.colors.secondary.resolved(scheme))
        case .started:
            Capsule().fill(theme.colors.tertiary.resolved(scheme))
        case .pending:
            Capsule().fill(theme.colors.warning.resolved(scheme))
        case nil:
            Capsule().fill(theme.colors.primary.resolved(scheme))
        }
    }

    /// The content and layout of the pill.
    ///
    /// Renders the text with a semi‑bold caption font, white foreground color, padding,
    /// and the colored capsule background.
    public var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(backgroundCapsule)
    }
}

