//
//  DSLabel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A design-system label that renders styled text (and optional icon) using theme typography.
///
/// `DSLabel` displays text according to a `DSLabelModel`, mapping the model's style
/// to design-system typography and colors. It supports an optional SF Symbols icon,
/// bold styling, and alignment.
///
/// ### Example
/// ```swift
/// DSLabel(DSLabelModel(text: "Hello", style: .title, systemImage: "star"))
/// ```
public struct DSLabel: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let model: DSLabelModel
    
    /// Creates a label with the given configuration model.
    /// - Parameter model: The label configuration (text, style, icon, alignment, color).
    public init(_ model: DSLabelModel) {
        self.model = model
    }
    
    /// The content and layout of the label.
    public var body: some View {
        content
    }
    
    /// The internal content that conditionally composes an icon with the text.
    @ViewBuilder
    private var content: some View {
        if let systemImage = model.systemImage, !systemImage.isEmpty {
            Label {
                textView
            } icon: {
                Image(systemName: systemImage)
            }
            .font(textFont)
            .foregroundColor(model.textColor)
        } else {
            textView
                .font(textFont)
                .foregroundColor(textColor)
        }
    }
    
    /// The base text view applying alignment, wrapping, and bold styling from the model.
    private var textView: some View {
        Text(model.text)
            .multilineTextAlignment(model.alignment)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .fontWeight(model.isBold ? .bold : nil)
    }
    
    /// Resolves the font from the design-system typography for the selected style.
    private var textFont: Font {
        textStyle(for: model.style).font
    }
    
    /// Resolves the text color from the theme, with special handling for accent and muted styles.
    private var textColor: Color {
        switch model.style {
        case .accent:
            return theme.colors.primary.resolved(scheme)
        case .muted:
            return theme.colors.textCaption.resolved(scheme)
        default:
            return textStyle(for: model.style).resolvedColor(scheme)
        }
    }
    
    /// Maps a `DSLabelModel.Style` to a design-system typography style.
    private func textStyle(for style: DSLabelModel.Style) -> DSTypography.TextStyle {
        switch style {
        case .h1:
            return theme.typography.h1
        case .h2:
            return theme.typography.h2
        case .h3:
            return theme.typography.h3
        case .title:
            return theme.typography.title
        case .subtitle:
            return theme.typography.subtitle
        case .body, .accent, .muted:
            return theme.typography.body
        case .caption:
            return theme.typography.caption
        case .overline:
            return theme.typography.overline
        }
    }
}

