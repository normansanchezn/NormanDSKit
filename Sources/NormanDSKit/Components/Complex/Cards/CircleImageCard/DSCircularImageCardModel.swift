//
//  DSCircularImageCardModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSCircularImageCardModel {
    public let imageURL: String
    public let name: String
    public let description: String
    public let imageSize: CGFloat
    
    public init(
        imageURL: String,
        name: String,
        description: String,
        imageSize: CGFloat = 72
    ) {
        self.imageURL = imageURL
        self.name = name
        self.description = description
        self.imageSize = imageSize
    }
}
