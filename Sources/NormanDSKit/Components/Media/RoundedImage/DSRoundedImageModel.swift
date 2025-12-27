//
//  DSRoundedImageModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model for `DSRoundedImage` describing the URL, size, corner radius, and background.
///
/// Use `DSRoundedImageModel` to define how a rounded image is rendered, including its remote URL,
/// square size, corner radius, and whether to display a subtle glass background.
///
/// ### Example
/// ```swift
/// let model = DSRoundedImageModel(
///     imageURL: "https://example.com/photo.jpg",
///     size: 120,
///     cornerRadius: 16,
///     showsGlassBackground: true
/// )
/// ```
public struct DSRoundedImageModel {
    /// The remote image URL string.
    public let imageURL: String
    /// The square image size in points.
    public let size: CGFloat
    /// The corner radius applied to the image.
    public let cornerRadius: CGFloat
    /// Whether to render a subtle glass background behind the image.
    public let showsGlassBackground: Bool
    
    /// Creates a model for `DSRoundedImage`.
    /// - Parameters:
    ///   - imageURL: The remote image URL string.
    ///   - size: The square image size in points. Defaults to `96`.
    ///   - cornerRadius: The corner radius in points. Defaults to `20`.
    ///   - showsGlassBackground: Whether to render a glass background. Defaults to `true`.
    public init(
        imageURL: String,
        size: CGFloat = 96,
        cornerRadius: CGFloat = 20,
        showsGlassBackground: Bool = true
    ) {
        self.imageURL = imageURL
        self.size = size
        self.cornerRadius = cornerRadius
        self.showsGlassBackground = showsGlassBackground
    }
}
