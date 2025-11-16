//
//  DSToggle.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSToggle: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    @Binding private var isOn: Bool
    private let isVisible: Bool
    
    public init(
        isOn: Binding<Bool>,
        isVisible: Bool = true
    ) {
        self._isOn = isOn
        self.isVisible = isVisible
    }
    
    public var body: some View {
        if isVisible {
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(
                    DSToggleStyle()
                )
        }
    }
}
