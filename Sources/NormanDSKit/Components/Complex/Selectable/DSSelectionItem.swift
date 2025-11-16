//
//  DSSelectionItem.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSSelectionItem: Identifiable, Equatable {
    public let id = UUID()
    public let title: String
    public let subtitle: String?
    public let icon: String?

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
