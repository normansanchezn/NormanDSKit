//
//  PkgString.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import Foundation

public func pkgString(_ key: String.LocalizationValue, table: String? = nil) -> String {
    if #available(iOS 16.0, macOS 13.0, *) {
        return String(localized: key, table: table, bundle: .module)
    } else {
        return NSLocalizedString(String(describing: key), tableName: table, bundle: .module, comment: "")
    }
}
