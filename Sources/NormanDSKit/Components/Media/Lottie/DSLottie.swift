//
//  DSLottie.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI
import Lottie

/// A lightweight SwiftUI wrapper for rendering Lottie animations.
///
/// `DSLottie` displays a named Lottie animation with optional width/height sizing and
/// an optional bundle. By default it plays in a continuous loop.
///
/// ### Example
/// ```swift
/// DSLottie(animationName: "empty_state", width: 240, height: 180)
/// ```
///
/// - Parameters:
///   - animationName: The Lottie animation name.
///   - width: Optional fixed width for the animation view. Default is `420`.
///   - height: Optional fixed height for the animation view. Default is `340`.
///   - bundle: The bundle where the animation asset is located. Default is `.main`.
public struct DSLottie: View {
    /// The Lottie animation name to load.
    private let animationName: String
    /// An optional fixed width for the rendered animation.
    private let width: CGFloat?
    /// An optional fixed height for the rendered animation.
    private let height: CGFloat?
    /// The bundle where the Lottie asset is located.
    private let bundle: Bundle

    /// Creates a new `DSLottie` view with a specified animation name, optional width and height, and bundle.
    ///
    /// - Parameters:
    ///   - animationName: The Lottie animation name.
    ///   - width: Optional fixed width for the animation view. Default is `420`.
    ///   - height: Optional fixed height for the animation view. Default is `340`.
    ///   - bundle: The bundle where the animation asset is located. Default is `.main`.
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

    /// The content and layout of the Lottie view.
    public var body: some View {
        LottieView(animation: .named(animationName, bundle: bundle))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .frame(width: width, height: height)
    }
}

