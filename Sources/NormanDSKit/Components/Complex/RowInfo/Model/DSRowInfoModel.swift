//
//  RowInfoModel.swift
//  MentorConnect
//
//  Created by Norman Sanchez on 19/11/25.
//

import SwiftUI

/// A data model for `DSRowInfo` describing schedule, title, participants, and actions.
///
/// Use `DSRowInfoModel` to pass the content and behavior of a row: date range,
/// title, duration, avatar URLs, extra count, and optional callbacks.
///
/// ### Example
/// ```swift
/// let model = DSRowInfoModel(
///     dateRange: "01/12/25 - 15/12/25",
///     title: "Refactor Authentication",
///     durationText: "2 weeks",
///     avatarURLs: ["https://example.com/a.jpg", "https://example.com/b.jpg"],
///     extraCount: 1,
///     onDelete: { print("Deleted") }
/// )
/// ```
public struct DSRowInfoModel: Identifiable {
    /// Stable identity for lists.
    public var id: UUID = UUID()
    /// The time range displayed at the top.
    public let dateRange: String
    /// The main title.
    public let title: String
    /// A short duration label.
    public let durationText: String
    /// Avatar image URLs (shown up to 3).
    public let avatarURLs: [String]
    /// Additional participant count beyond the visible avatars.
    public let extraCount: Int
    public var statusText: String
    /// Optional menu tap callback.
    public var onMenuTap: (() -> Void)?
    /// Optional delete callback used by swipe actions.
    public var onDelete: (() -> Void)?
    
    /// Creates a row info model.
    /// - Parameters:
    ///   - dateRange: The time range displayed at the top.
    ///   - title: The main title.
    ///   - durationText: A short duration label.
    ///   - avatarURLs: Avatar image URLs (up to 3 are shown).
    ///   - extraCount: Additional participant count beyond the visible avatars.
    ///   - onMenuTap: Optional menu tap callback.
    ///   - onDelete: Optional delete callback used by swipe actions.
    public init(
        dateRange: String,
        title: String,
        durationText: String,
        avatarURLs: [String],
        extraCount: Int,
        statusText: String,
        onMenuTap: (() -> Void)? = nil,
        onDelete: (() -> Void)? = nil
    ) {
        self.dateRange = dateRange
        self.title = title
        self.durationText = durationText
        self.avatarURLs = avatarURLs
        self.extraCount = extraCount
        self.statusText = statusText
        self.onMenuTap = onMenuTap
        self.onDelete = onDelete
    }
}

