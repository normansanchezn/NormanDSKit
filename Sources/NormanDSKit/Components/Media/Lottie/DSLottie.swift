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
    private let bundle: Bundle

    public init(
        animationName: String,
        width: CGFloat? = 420,
        height: CGFloat? = 340,
        bundle: Bundle = .main
    ) {
        self.animationName = animationName
        self.width = width
        self.height = height
        self.bundle = bundle
    }

    public var body: some View {
        LottieView(animation: .named(animationName, bundle: bundle))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .frame(width: width, height: height)
    }
}

