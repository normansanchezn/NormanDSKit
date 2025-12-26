//
//  DSLabel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model describing the content and style of a `DSLabel`.
///
/// Use `DSLabelModel` to specify text, style, optional icon, bold appearance,
/// alignment, and an optional explicit color.
///
/// ### Example
/// ```swift
/// let model = DSLabelModel(
///     text: "Welcome",
///     style: .title,
///     systemImage: "sparkles",
///     isBold: true,
///     alignment: .center
/// )
/// ```
public struct DSLabelModel {
    
    /// Predefined text styles for labels.
    ///
    /// - h1: Large heading style.
    /// - h2: Medium-large heading style.
    /// - h3: Medium heading style.
    /// - title: Section or screen title style.
    /// - subtitle: Secondary title/subtitle style.
    /// - body: Standard body text style.
    /// - caption: Small caption text style.
    /// - overline: Overline/supplementary text style.
    /// - accent: Accent-emphasized body style (uses primary color).
    /// - muted: Muted/secondary body style (uses caption color).
    public enum Style {
        case h1
        case h2
        case h3
        case title
        case subtitle
        case body
        case caption
        case overline
        case accent
        case muted
    }
    
    /// The label's visible text.
    public let text: String
    /// The predefined text style to apply.
    public let style: Style
    /// An optional SF Symbols system image name displayed with the text.
    public let systemImage: String?
    /// Whether the text should render in bold weight.
    public let isBold: Bool
    /// The multiline text alignment for the label.
    public let alignment: TextAlignment
    /// An optional explicit text color. When nil, the theme-resolved color is used.
    public let textColor: Color?
    
    /// Creates a label model.
    ///
    /// - Parameters:
    ///   - text: The label's text.
    ///   - style: The style to apply. Default is `.body`.
    ///   - systemImage: An optional SF Symbols name to show with the text.
    ///   - isBold: Whether the text is bold. Default is `false`.
    ///   - alignment: The multiline alignment. Default is `.leading`.
    ///   - textColor: An explicit color override. Default is `Color.primary`.
    public init(
        text: String,
        style: Style = .body,
        systemImage: String? = nil,
        isBold: Bool = false,
        alignment: TextAlignment = .leading,
        textColor: Color? = Color.primary
    ) {
        self.text = text
        self.style = style
        self.systemImage = systemImage
        self.isBold = isBold
        self.alignment = alignment
        self.textColor = textColor
    }
}

