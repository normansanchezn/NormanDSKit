//
//  DSEmptyPlaceHolderModel.swift
//  MentorConnect
//
//  Created by Norman Sanchez on 19/11/25.
//

import SwiftUI

public struct DSEmptyPlaceHolderModel {
    public let animationSource: String
    public let placeHolderText: String
    public let animationHight: CGFloat
    public let placeHolderSize: CGFloat
    
    public init(
        animationSource: String,
        placeHolderText: String,
        animationHight: CGFloat = 250.0,
        placeHolderSize: CGFloat = 200.0
    ) {
        self.animationSource = animationSource
        self.placeHolderText = placeHolderText
        self.animationHight = animationHight
        self.placeHolderSize = placeHolderSize
    }
}
