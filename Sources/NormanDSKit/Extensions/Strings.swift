//
//  Strings.swift
//  NormanDSKit
//
//  Created by Norman on 05/01/26.
//

public extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
