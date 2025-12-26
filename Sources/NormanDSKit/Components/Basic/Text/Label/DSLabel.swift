//
//  DSLabel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSLabel: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let model: DSLabelModel
    
    public init(_ model: DSLabelModel) {
        self.model = model
    }
    
    public var body: some View {
        content
    }
    
    @ViewBuilder
    private var content: some View {
        if let systemImage = model.systemImage, !systemImage.isEmpty {
            Label {
                textView
            } icon: {
                Image(systemName: systemImage)
            }
            .font(textFont)
            .foregroundColor(model.textColor)
        } else {
            textView
                .font(textFont)
                .foregroundColor(textColor)
        }
    }
    
    // MARK: - Text View Base
    
    private var textView: some View {
        Text(model.text)
            .multilineTextAlignment(model.alignment)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .fontWeight(model.isBold ? .bold : nil)
    }
    
    // MARK: - Font & Color
    private var textFont: Font {
        textStyle(for: model.style).font
    }
    
    private var textColor: Color {
        switch model.style {
        case .accent:
            return theme.colors.primary.resolved(scheme)
        case .muted:
            return theme.colors.textCaption.resolved(scheme)
        default:
            return textStyle(for: model.style).resolvedColor(scheme)
        }
    }
    
    private func textStyle(for style: DSLabelModel.Style) -> DSTypography.TextStyle {
        switch style {
        case .h1:
            return theme.typography.h1
        case .h2:
            return theme.typography.h2
        case .h3:
            return theme.typography.h3
        case .title:
            return theme.typography.title
        case .subtitle:
            return theme.typography.subtitle
        case .body, .accent, .muted:
            return theme.typography.body
        case .caption:
            return theme.typography.caption
        case .overline:
            return theme.typography.overline
        }
    }
}
