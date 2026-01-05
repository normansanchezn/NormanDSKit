//
//  DSDetailsDialogStatus.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import Foundation

public enum DSStatus: String, Codable, CaseIterable, Identifiable {
    case completed
    case inProcess
    case started
    case pending
    case error

    public var id: String { rawValue }
}

public extension DSStatus {
    init?(from string: String) {
        let normalized = Self.normalize(string)
        self.init(rawValue: normalized)
    }

    private static func normalize(_ s: String) -> String {
        let cleaned = s
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "_", with: "")
            .replacingOccurrences(of: "-", with: "")
            .lowercased()

        switch cleaned {
                case "completed": return "Completed"
                case "inprocess", "In process": return "In process"
                case "started": return "Started"
                case "pending": return "Pending"
                case "error": return "Error"
                default:
                    return s.trimmingCharacters(in: .whitespacesAndNewlines)
                }
    }
}
