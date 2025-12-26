//
//  DSCircularImageCardModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model for `DSCircularImageCard` describing image URL, name, description, and size.
///
/// ### Example
/// ```swift
/// let model = DSCircularImageCardModel(
///     imageURL: "https://example.com/avatar.jpg",
///     name: "Alice",
///     description: "Designer",
///     imageSize: 72
/// )
/// ```
public struct DSCircularImageCardModel {
    /// The remote image URL used for the circular avatar.
    public let imageURL: String
    /// The primary text shown below the image.
    public let name: String
    /// The secondary text shown below the name.
    public let description: String
    /// The diameter of the circular image, in points.
    public let imageSize: CGFloat
    
    /// Creates a circular image card model.
    /// - Parameters:
    ///   - imageURL: The remote image URL for the avatar.
    ///   - name: The primary text to display.
    ///   - description: The secondary text to display.
    ///   - imageSize: The diameter of the circular image. Default is 72.
    public init(
        imageURL: String,
        name: String,
        description: String,
        imageSize: CGFloat = 72
    ) {
        self.imageURL = imageURL
        self.name = name
        self.description = description
        self.imageSize = imageSize
    }
}
