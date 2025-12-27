//
//  DSInfoModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 17/11/25.
//

import SwiftUI

/// A simple information model with title, subtitle, and optional image.
///
/// Use `DSInfoModel` to represent lightweight pieces of content (e.g., items in an info list
/// or grid), including a stable identifier, a title, a subtitle, and an optional `Image`.
///
/// ### Example
/// ```swift
/// let info = DSInfoModel(title: "Swift", subtitle: "Programming Language", image: Image(systemName: "swift"))
/// ```
public struct DSInfoModel: Identifiable {
    /// A stable identifier for the info item.
    public var id: UUID = UUID()
    /// The main title text.
    public var title: String
    /// The supporting subtitle text.
    public var subtitle: String
    /// An optional image to display with the info item.
    public var image: Image?
    
    /// Creates an info model.
    /// - Parameters:
    ///   - title: The main title text.
    ///   - subtitle: The supporting subtitle text.
    ///   - image: An optional image to display.
    public init(title: String, subtitle: String, image: Image? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
