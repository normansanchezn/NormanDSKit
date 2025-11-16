//
//  DSLottie.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI
import Lottie

public struct DSLottie: View {
    private let animationName: String
    private let width: CGFloat?
    private let height: CGFloat?
    
    public init(
        animationName: String,
        width: CGFloat? = 420,
        height: CGFloat? = 340
    ) {
        self.animationName = animationName
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        LottieView(animation: .named(animationName))
            .playbackMode(
                .playing(
                    .toProgress(1, loopMode: .loop)
                )
            )
            .frame(width: width, height: height)
    }
}
