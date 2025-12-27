//
//  DSEmptyPlaceholder.swift
//  MentorConnect
//
//  Created by Norman Sanchez on 19/11/25.
//

import SwiftUI

/// An empty state placeholder with an animation and a message.
///
/// `DSEmptyPlaceholder` shows an animation (e.g., a Lottie resource) and a centered message
/// styled with the design system. Use this component to communicate empty or loading states.
///
/// ### Example
/// ```swift
/// DSEmptyPlaceholder(
///     dsPlaceHolderModel: .init(
///         animationSource: "empty_state",
///         placeHolderText: "No results found",
///         animationHight: 180,
///         placeHolderSize: 260
///     )
/// )
/// ```
///
/// - Parameter dsPlaceHolderModel: The configuration describing the animation and text.
/// - Environment:
///   - dsTheme: Design system theme used for spacing and colors.
public struct DSEmptyPlaceholder: View {
    @Environment(\.dsTheme) private var theme
    
    public let animationHight: CGFloat
    public let placeHolderSize: CGFloat
    public let placeHolderText: String
    public let animationName: String
    
    public init(dsPlaceHolderModel: DSEmptyPlaceHolderModel) {
        self.animationHight = dsPlaceHolderModel.animationHight
        self.placeHolderSize = dsPlaceHolderModel.placeHolderSize
        self.placeHolderText = dsPlaceHolderModel.placeHolderText
        self.animationName = dsPlaceHolderModel.animationSource
    }
    
    public var body: some View {
        LazyVStack(alignment: .center) {
            DSLottie(
                animationName: animationName,
                height: animationHight
            )
            .padding(.top, theme.spacing.xl)
            
            DSLabel(
                .init(text: placeHolderText, style: DSLabelModel.Style.subtitle, alignment: .center)
            )
            .frame(maxWidth: placeHolderSize)
            .padding()
            .mcGlassEffectIfAvailable()
            .padding(theme.spacing.xl)
        }
        .padding(.horizontal, theme.spacing.xl)
    }
}
