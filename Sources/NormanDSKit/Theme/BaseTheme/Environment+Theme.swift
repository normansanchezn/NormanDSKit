//
//  Environment+Theme.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 05/11/25.
//

import SwiftUI

// MARK: - EnvironmentKey
private struct DSThemeKey: EnvironmentKey {
    nonisolated(unsafe) static var defaultValue: DSTheme = DSTheme()
}

// MARK: - EnvironmentValues
public extension EnvironmentValues {
    @MainActor
    var dsTheme: DSTheme {
        get { self[DSThemeKey.self] }
        set { self[DSThemeKey.self] = newValue }
    }
}

// MARK: - View Modifier to inject theme
public extension View {
    @MainActor
    func dsTheme(_ theme: DSTheme) -> some View {
        environment(\.dsTheme, theme)
    }
}
