//
//  DSLabel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSLabelModel {
    
    public enum Style {
        case h1
        case h2
        case h3
        case title
        case subtitle
        case body
        case caption
        case overline
        case accent
        case muted
    }
    
    public let text: String
    public let style: Style
    public let systemImage: String?
    public let isBold: Bool
    public let alignment: TextAlignment
    public let textColor: Color?
    
    public init(
        text: String,
        style: Style = .body,
        systemImage: String? = nil,
        isBold: Bool = false,
        alignment: TextAlignment = .leading,
        textColor: Color? = Color.primary
    ) {
        self.text = text
        self.style = style
        self.systemImage = systemImage
        self.isBold = isBold
        self.alignment = alignment
        self.textColor = textColor
    }
}
