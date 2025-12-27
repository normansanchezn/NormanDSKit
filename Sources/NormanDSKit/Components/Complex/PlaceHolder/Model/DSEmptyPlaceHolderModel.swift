//
//  DSEmptyPlaceHolderModel.swift
//  MentorConnect
//
//  Created by Norman Sanchez on 19/11/25.
//

import SwiftUI

/// A configuration model for `DSEmptyPlaceHolder` describing the animation and text.
///
/// Use `DSEmptyPlaceHolderModel` to provide the animation resource, placeholder text,
/// and sizing values used by the empty state view.
///
/// ### Example
/// ```swift
/// let model = DSEmptyPlaceHolderModel(
///     animationSource: "empty_inbox",
///     placeHolderText: "No results found",
///     animationHight: 220,
///     placeHolderSize: 180
/// )
/// ```
public struct DSEmptyPlaceHolderModel {
    /// The name or URL of the animation resource to display.
    public let animationSource: String
    /// The message shown below the animation.
    public let placeHolderText: String
    /// The height of the animation in points.
    public let animationHight: CGFloat
    /// The maximum width of the placeholder text container in points.
    public let placeHolderSize: CGFloat
    
    /// Creates a model for `DSEmptyPlaceHolder`.
    /// - Parameters:
    ///   - animationSource: The animation resource name or URL.
    ///   - placeHolderText: The message shown below the animation.
    ///   - animationHight: The animation height in points. Defaults to `250`.
    ///   - placeHolderSize: The maximum width of the placeholder text container in points. Defaults to `200`.
    public init(
        animationSource: String,
        placeHolderText: String,
        animationHight: CGFloat = 250.0,
        placeHolderSize: CGFloat = 200.0
    ) {
        self.animationSource = animationSource
        self.placeHolderText = placeHolderText
        self.animationHight = animationHight
        self.placeHolderSize = placeHolderSize
    }
}

