//
//  DSPersonalCard.swift
//  NormanDSKit
//
//  Created by Norman on 26/12/25.
//

import SwiftUI

/// A configuration model for `DSUserCard` describing the avatar, texts, colors, size, and tap action.
///
/// Use `DSUserCardModel` to supply the content and behavior for `DSUserCard`.
///
/// ### Example
/// ```swift
/// let model = DSUserCardModel(
///     imageURL: "https://example.com/avatar.jpg",
///     name: "Alex Doe",
///     jobDescription: "iOS Engineer",
///     actionCallback: { print("Tapped") },
///     heightSize: 220,
///     widthSize: 150,
///     colorBackground: .blue
/// )
/// ```
public struct DSUserCardModel: Identifiable {
    /// A stable identifier for the model.
    public var id: UUID = UUID()
    /// The remote image URL used to render the rounded avatar.
    public var imageURL: String
    /// The person's display name shown as the primary text.
    public var name: String
    /// A short job description or subtitle shown below the name.
    public var jobDescription: String
    /// The closure executed when the user taps the card.
    public var actionCallback: () -> Void = { }
    /// The explicit width of the card in points.
    public var widthSize: CGFloat
    /// The explicit height of the card in points.
    public var heightSize: CGFloat
    /// The base color used for the decorative rotated background.
    public var colorBackground: Color
    
    /// Creates a user card model.
    /// - Parameters:
    ///   - imageURL: The remote image URL used to render the avatar.
    ///   - name: The person's display name.
    ///   - jobDescription: A short job description or subtitle.
    ///   - actionCallback: The closure executed when the card is tapped.
    ///   - heightSize: The card height in points. Defaults to `220`.
    ///   - widthSize: The card width in points. Defaults to `150`.
    ///   - colorBackground: The base color for the decorative background.
    public init(
        imageURL: String,
        name: String,
        jobDescription: String,
        actionCallback: @escaping () -> Void,
        heightSize: CGFloat = 220,
        widthSize: CGFloat = 150,
        colorBackground: Color
    ) {
        self.imageURL = imageURL
        self.name = name
        self.jobDescription = jobDescription
        self.actionCallback = actionCallback
        self.widthSize = widthSize
        self.heightSize = heightSize
        self.colorBackground = colorBackground
    }
}
