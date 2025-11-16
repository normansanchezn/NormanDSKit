//
//  MentorConnectCircularImageModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 11/11/25.
//

import SwiftUI

public struct MentorConnectCircularImageModel: Identifiable {
    public var id: UUID = UUID()
    public var image: String
    public var size: CGFloat
    
    public init(image: String, size: CGFloat) {
        self.image = image
        self.size = size
    }
}
