//
//  DSRoundedImageModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSRoundedImageModel {
    public let imageURL: String
    public let size: CGFloat
    public let cornerRadius: CGFloat
    public let showsGlassBackground: Bool
    
    public init(
        imageURL: String,
        size: CGFloat = 96,
        cornerRadius: CGFloat = 20,
        showsGlassBackground: Bool = true
    ) {
        self.imageURL = imageURL
        self.size = size
        self.cornerRadius = cornerRadius
        self.showsGlassBackground = showsGlassBackground
    }
}
