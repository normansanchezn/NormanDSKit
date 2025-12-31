//
//  DSCardModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model for `DSCard` describing title, subtitle, image, and tap action.
///
/// Use `DSCardModel` to provide the visible content and optional behavior for a card.
/// When `action` is provided, the card becomes tappable.
///
/// ### Example
/// ```swift
/// let model = DSCardModel(
///     title: DSLabelModel(text: "Alice", style: .body),
///     subtitle: DSLabelModel(text: "Designer", style: .caption),
///     imageURL: "https://example.com/alice.jpg",
///     imageSize: 72,
///     action: { print("Tapped") }
/// )
/// ```
public struct DSCardModel {
    /// The primary label displayed as the card title.
    public let title: DSLabelModel
    /// An optional secondary label displayed below the title.
    public let subtitle: DSLabelModel?
    
    /// An optional remote image URL used for the avatar.
    public let imageURL: String?
    /// An optional explicit avatar size in points.
    public let imageSize: CGFloat?
    
    /// An optional closure executed when the card is tapped.
    public let action: (() -> Void)?
    public let backgroundColor: Color?
    
    /// Creates a card model.
    /// - Parameters:
    ///   - title: The primary label displayed as the title.
    ///   - subtitle: An optional secondary label.
    ///   - imageURL: An optional remote image URL for the avatar.
    ///   - imageSize: An optional avatar size in points.
    ///   - action: An optional closure executed when the card is tapped.
    public init(
        title: DSLabelModel,
        subtitle: DSLabelModel? = nil,
        imageURL: String? = nil,
        imageSize: CGFloat? = nil,
        action: (() -> Void)? = nil,
        backgroundColor: Color? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.imageSize = imageSize
        self.action = action
        self.backgroundColor = backgroundColor
    }
}
