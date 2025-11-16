//
//  DSCardModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSCardModel {
    public let title: DSLabelModel
    public let subtitle: DSLabelModel?
    
    public let imageURL: String?
    public let imageSize: CGFloat?
    
    public let action: (() -> Void)?
    
    public init(
        title: DSLabelModel,
        subtitle: DSLabelModel? = nil,
        imageURL: String? = nil,
        imageSize: CGFloat? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.imageSize = imageSize
        self.action = action
    }
}
