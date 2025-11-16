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
        case accent      // para cosas que quieras resaltar con primary
        case muted       // texto más apagado
    }
    
    public let text: String
    public let style: Style
    public let systemImage: String?
    public let isBold: Bool
    public let alignment: TextAlignment
    
    public init(
        text: String,
        style: Style = .body,
        systemImage: String? = nil,
        isBold: Bool = false,
        alignment: TextAlignment = .leading
    ) {
        self.text = text
        self.style = style
        self.systemImage = systemImage
        self.isBold = isBold
        self.alignment = alignment
    }
}
