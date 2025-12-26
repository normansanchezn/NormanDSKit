//
//  DSButtonModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model describing the content and style of a `DSButton`.
///
/// Use `DSButtonModel` to specify the button's title, optional system image,
/// variant, sizing, and enabled state.
///
/// ### Example
/// ```swift
/// let model = DSButtonModel(
///     title: "Continue",
///     systemImage: "arrow.right",
///     variant: .primary,
///     isFullWidth: true
/// )
/// ```
public struct DSButtonModel {
    /// The button's visible title.
    public let title: String
    /// An optional SF Symbols system image name displayed before the title.
    public let systemImage: String?
    /// The visual variant that controls the button's emphasis and styling.
    public let variant: DSButtonVariant
    /// Whether the button expands to fill the available horizontal space.
    public let isFullWidth: Bool
    /// A Boolean value that enables or disables interactions.
    public let isEnabled: Bool
    /// The minimum height for the button's tappable area.
    public let minHeight: CGFloat
    
    /// Creates a button model.
    ///
    /// - Parameters:
    ///   - title: The button's visible title.
    ///   - systemImage: An optional SF Symbols name shown before the title.
    ///   - variant: The visual variant for emphasis and styling.
    ///   - isFullWidth: Whether the button should expand horizontally. Default is `true`.
    ///   - isEnabled: Whether the button is interactable. Default is `true`.
    ///   - minHeight: The minimum height for the button. Default is 30.
    public init(
        title: String,
        systemImage: String? = nil,
        variant: DSButtonVariant,
        isFullWidth: Bool = true,
        isEnabled: Bool = true,
        minHeight: CGFloat = 30
    ) {
        self.title = title
        self.systemImage = systemImage
        self.variant = variant
        self.isFullWidth = isFullWidth
        self.isEnabled = isEnabled
        self.minHeight = minHeight
    }
}
