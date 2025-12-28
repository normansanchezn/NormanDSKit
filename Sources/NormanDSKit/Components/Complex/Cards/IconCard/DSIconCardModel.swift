//
//  DSIconCardModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model for `DSIconCard` defining title, icon, size, and action.
///
/// Use `DSIconCardModel` to describe the visible content of the icon card and the
/// action executed when the user taps the card.
///
/// ### Example
/// ```swift
/// let model = DSIconCardModel(
///     title: "Be a mentor",
///     systemImage: "figure.2",
///     size: .large
/// ) {
///     print("Mentor action")
/// }
/// ```
public struct DSIconCardModel {
    /// Available sizes for the icon card.
    public enum Size {
        /// Small size (approximately 56 pt).
        case small
        /// Medium size (approximately 72 pt).
        case medium
        /// Large size (approximately 96 pt).
        case large
    }
    
    /// The text displayed below the icon.
    public let title: String
    /// The SF Symbols name (e.g., "doc", "figure.2").
    public let systemImage: String
    /// The visual size of the card.
    public let size: Size
    /// The action executed when the card is tapped.
    public let action: () -> Void
    public let backgroundColor: Color
    
    /// Creates a model for `DSIconCard`.
    /// - Parameters:
    ///   - title: The text displayed below the icon.
    ///   - systemImage: The SF Symbols name to display.
    ///   - size: The visual size of the card. Defaults to `.medium`.
    ///   - action: The action to execute when the card is tapped.
    public init(
        title: String,
        systemImage: String,
        size: Size = .medium,
        action: @escaping () -> Void,
        backgroundColor: Color
    ) {
        self.title = title
        self.systemImage = systemImage
        self.size = size
        self.action = action
        self.backgroundColor = backgroundColor
    }
}

