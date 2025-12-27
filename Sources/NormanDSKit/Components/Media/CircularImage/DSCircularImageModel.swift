//
//  DSCircularImageModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model for `DSCircularImage` describing the remote URL, size, and border.
///
/// Use `DSCircularImageModel` to define how the circular image is rendered, including the
/// image URL, the diameter in points, and whether a border should be shown.
///
/// ### Example
/// ```swift
/// let model = DSCircularImageModel(
///     imageURL: "https://example.com/avatar.jpg",
///     size: 72,
///     showsBorder: true
/// )
/// ```
public struct DSCircularImageModel {
    /// The remote image URL string.
    public let imageURL: String
    /// The circular image diameter in points.
    public let size: CGFloat
    /// Whether to draw a circular border around the image.
    public let showsBorder: Bool
    
    /// Creates a model for `DSCircularImage`.
    /// - Parameters:
    ///   - imageURL: The remote image URL string.
    ///   - size: The circular image diameter in points. Defaults to `72`.
    ///   - showsBorder: Whether to draw the border. Defaults to `true`.
    public init(
        imageURL: String,
        size: CGFloat = 72,
        showsBorder: Bool = true
    ) {
        self.imageURL = imageURL
        self.size = size
        self.showsBorder = showsBorder
    }
}
