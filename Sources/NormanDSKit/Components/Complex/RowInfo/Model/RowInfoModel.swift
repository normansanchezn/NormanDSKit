//
//  RowInfoModel.swift
//  MentorConnect
//
//  Created by Norman Sanchez on 19/11/25.
//

import SwiftUI

public struct RowInfoModel: Identifiable {
    public var id: UUID = UUID()
    public let dateRange: String
    public let title: String
    public let durationText: String
    public let avatarURLs: [String]
    public let extraCount: Int
    public var onMenuTap: (() -> Void)?
    public var onDelete: (() -> Void)? = nil
    
    public init(
        dateRange: String,
        title: String,
        durationText: String,
        avatarURLs: [String],
        extraCount: Int,
        onMenuTap: (() -> Void)? = nil,
        onDelete: (() -> Void)? = nil
    ) {
        self.dateRange = dateRange
        self.title = title
        self.durationText = durationText
        self.avatarURLs = avatarURLs
        self.extraCount = extraCount
        self.onMenuTap = onMenuTap
        self.onDelete = onDelete
    }
}
