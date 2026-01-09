//
//  EmojiImageView.swift
//  NormanDSKit
//
//  Created by Norman on 09/01/26.
//

import SwiftUI

public struct DSEmojiImageView: View {
    private var imgResName: String
    private var size: CGFloat
    private var scale: CGFloat
    private var accessibilityIsHidden: Bool

    public init(imgResName: String, size: CGFloat = 80, scale: CGFloat = 1.15, accessibilityIsHidden: Bool = true) {
        self.imgResName = imgResName
        self.size = size
        self.scale = scale
        self.accessibilityIsHidden = accessibilityIsHidden
    }
    
    public var body: some View {
        Image(imgResName, bundle: .module)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .scaleEffect(scale)
            .frame(width: size, height: size)
            .clipped()
            .accessibilityHidden(accessibilityIsHidden)
    }
}
