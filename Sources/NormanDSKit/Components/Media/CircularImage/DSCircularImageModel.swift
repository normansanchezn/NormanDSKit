//
//  DSCircularImageModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSCircularImageModel {
    public let imageURL: String
    public let size: CGFloat
    public let showsBorder: Bool
    
    public init(
        imageURL: String,
        size: CGFloat = 72,
        showsBorder: Bool = true
    ) {
        self.imageURL = imageURL
        self.size = size
        self.showsBorder = showsBorder
    }
}
