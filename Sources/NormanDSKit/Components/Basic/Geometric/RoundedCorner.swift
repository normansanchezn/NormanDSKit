//
//  RoundedCorner.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

/// A shape that rounds specified corners of a rectangle by a given radius.
///
/// Use `RoundedCorner` when you need to round a subset of corners (e.g., top-left and
/// top-right only), which isn't directly supported by `RoundedRectangle`.
///
/// ### Example
///
/// ```swift
/// RoundedCorner(radius: 12, corners: [.topLeft, .topRight])
///     .fill(Color.blue)
/// ```
public struct RoundedCorner: Shape {
    /// The corner radius to apply to the specified corners.
    public var radius: CGFloat = .infinity
    /// The set of corners to round (e.g., `.topLeft`, `.bottomRight`).
    public var corners: UIRectCorner = []
    
    /// Creates a new `RoundedCorner` shape.
    ///
    /// - Parameters:
    ///   - radius: The corner radius to apply.
    ///   - corners: The set of corners to round.
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
    
    /// Produces a path for the shape within the given rectangle.
    ///
    /// - Parameter rect: The bounding rectangle of the shape.
    /// - Returns: A `Path` that rounds the specified corners by the configured radius.
    public func path(in rect: CGRect) -> Path {
        let bezier = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(bezier.cgPath)
    }
}
