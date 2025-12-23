//
//  DSEmptyPlaceholder.swift
//  MentorConnect
//
//  Created by Norman Sanchez on 19/11/25.
//

import SwiftUI

public struct DSEmptyPlaceholder: View {
    @Environment(\.dsTheme) private var theme
    
    public let animationHight: CGFloat
    public let placeHolderSize: CGFloat
    public let placeHolderText: String
    public let animationName: String
    
    init(dsPlaceHolderModel: DSEmptyPlaceHolderModel) {
        self.animationHight = dsPlaceHolderModel.animationHight
        self.placeHolderSize = dsPlaceHolderModel.placeHolderSize
        self.placeHolderText = dsPlaceHolderModel.placeHolderText
        self.animationName = dsPlaceHolderModel.animationSource
    }
    
    public var body: some View {
        LazyVStack(alignment: .center) {
            DSLottie(
                animationName: placeHolderText,
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
