//
//  MentorConnectImageCircularCardModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 10/11/25.
//

import SwiftUI

public struct MentorConnectCircularImageCardModel: Identifiable {
    public var id: UUID = UUID()
    public var name: String
    public var description: String
    public var imageName: String
    public var imageSize: CGFloat
    
    public init(name: String, description: String, imageName: String, imageSize: CGFloat = 100) {
        self.name = name
        self.description = description
        self.imageName = imageName
        self.imageSize = imageSize
    }
}
