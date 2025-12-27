//
//  DSSelectionItem.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A selectable item model used by `DSSelectableList` and `DSSelectableRow`.
///
/// `DSSelectionItem` describes a choice with a title, optional subtitle, and optional
/// SF Symbol icon. It conforms to `Identifiable` and `Equatable` for use in lists
/// and selection bindings.
///
/// ### Example
/// ```swift
/// let items: [DSSelectionItem] = [
///     .init(title: "iOS", subtitle: "Mobile", icon: "iphone"),
///     .init(title: "Android", subtitle: "Mobile", icon: "android.logo"),
///     .init(title: "Flutter")
/// ]
/// ```
public struct DSSelectionItem: Identifiable, Equatable {
    /// Stable identity for use in lists.
    public let id = UUID()
    /// The main display text.
    public let title: String
    /// Optional supporting text.
    public let subtitle: String?
    /// Optional SF Symbols name to display next to the title.
    public let icon: String?

    /// Creates a selection item.
    /// - Parameters:
    ///   - title: The main display text.
    ///   - subtitle: Optional supporting text.
    ///   - icon: Optional SF Symbols name to display next to the title.
    public init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
}

