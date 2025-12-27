//
//  DSScreenHeader.swift
//  NormanDSKit
//
//  Created by Norman on 26/12/25.
//

import SwiftUI

/// A simple screen header that displays a large title using the design system.
///
/// `DSScreenHeader` renders a prominent title styled with the DS theme and the
/// current color scheme. Use it at the top of a screen to provide a clear
/// heading.
///
/// ### Example
/// ```swift
/// DSScreenHeader(titleScreen: "Screen title")
/// ```
///
/// - Parameters:
///   - titleScreen: The text displayed as the screen's main title.
///
/// - Environment:
///   - dsTheme: Design system theme used to resolve colors, typography, spacing, and radii.
///   - colorScheme: The current color scheme (light/dark) used to resolve colors.
public struct DSScreenHeader : View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    public var titleScreen: String
    
    public init(titleScreen: String) {
        self.titleScreen = titleScreen
    }
    
    public var body: some View {
        HStack {
            DSLabel(
                .init(
                    text: titleScreen,
                    style: DSLabelModel.Style.h1,
                    textColor: theme.colors.primary.resolved(scheme)
                )
            )
            Spacer()
        }
    }
}

#Preview {
    ScrollView {
        DSScreenHeader(titleScreen:"Screen title")
    }
}
