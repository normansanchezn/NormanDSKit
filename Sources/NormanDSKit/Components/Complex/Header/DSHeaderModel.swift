//
//  DSHeaderModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSHeaderModel {
    
    public enum Style {
        case large      // tipo Large Title (Home / root)
        case standard   // tipo barra normal (detalle, flows)
    }
    
    public let title: String
    public let subtitle: String?
    public let systemImage: String?
    public let style: Style
    public let showsBackButton: Bool
    public let showsCloseButton: Bool
    
    public init(
        title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        style: Style = .large,
        showsBackButton: Bool = false,
        showsCloseButton: Bool = false
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.style = style
        self.showsBackButton = showsBackButton
        self.showsCloseButton = showsCloseButton
    }
}
