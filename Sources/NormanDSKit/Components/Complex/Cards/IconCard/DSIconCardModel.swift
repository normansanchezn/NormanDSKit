//
//  DSIconCardModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSIconCardModel {
    public enum Size {
        case small
        case medium
        case large
    }
    
    public let title: String
    public let systemImage: String
    public let size: Size
    public let action: () -> Void
    
    public init(
        title: String,
        systemImage: String,
        size: Size = .medium,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.size = size
        self.action = action
    }
}
