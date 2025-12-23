//
//  DSButtonModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSButtonModel {
    public let title: String
    public let systemImage: String?
    public let variant: DSButtonVariant
    public let isFullWidth: Bool
    public let isEnabled: Bool
    public let minHeight: CGFloat
    
    public init(
        title: String,
        systemImage: String? = nil,
        variant: DSButtonVariant,
        isFullWidth: Bool = true,
        isEnabled: Bool = true,
        minHeight: CGFloat = 30
    ) {
        self.title = title
        self.systemImage = systemImage
        self.variant = variant
        self.isFullWidth = isFullWidth
        self.isEnabled = isEnabled
        self.minHeight = minHeight
    }
}
