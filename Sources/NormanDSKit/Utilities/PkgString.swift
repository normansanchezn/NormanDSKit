//
//  PkgString.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import Foundation

/// Returns a localized string from this package's module bundle.
///
/// This helper resolves a ``Swift/String/LocalizationValue`` using the package's
/// ``Swift/Bundle/module`` so that localization works correctly when the code is
/// distributed as a Swift Package.
///
/// On iOS 16 / macOS 13 and later, it uses ``Swift/String/init(localized:table:bundle:comment:)``.
/// On earlier systems, it falls back to ``Foundation/NSLocalizedString(_:tableName:bundle:value:comment:)``.
///
/// - Parameters:
///   - key: The localization key as a ``Swift/String/LocalizationValue``.
///          For example: "login.title" or "field.email.placeholder".
///   - table: An optional strings table name. Pass `nil` to use the default
///            "Localizable" table.
/// - Returns: The localized string found in the specified table within ``Swift/Bundle/module``.
///
/// ### Examples
///
/// Localize a simple title using the default table:
/// ```swift
/// let title = pkgString("login.title")
/// ```
///
/// Localize from a custom table named "Auth":
/// ```swift
/// let placeholder = pkgString("email.placeholder", table: "Auth")
/// ```
///
/// Use in SwiftUI:
/// ```swift
/// Text(pkgString("welcome.message"))
/// ```
///
/// - Important: Ensure your `.strings` files (for example, `Localizable.strings`)
///   are included under the package target's processed resources so they are
///   available via ``Swift/Bundle/module``.
public func pkgString(_ key: String.LocalizationValue, table: String? = nil) -> String {
    if #available(iOS 16.0, macOS 13.0, *) {
        return String(localized: key, table: table, bundle: .module)
    } else {
        return NSLocalizedString(String(describing: key), tableName: table, bundle: .module, comment: "")
    }
}
