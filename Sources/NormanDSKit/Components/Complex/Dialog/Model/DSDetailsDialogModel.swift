//
//  DSDetailsDialogModel.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import SwiftUI

public struct DSDetailsDialogModel {
    public let title: String
    public let dateRange: String
    public let durationText: String
    public let status: DSStatus

    public let primaryTitle: String
    public let secondaryTitle: String?

    public let onClose: () -> Void
    public let onPrimary: () -> Void
    public let onSecondary: (() -> Void)?
    public let onStatusChanged: (DSStatus) -> Void
    
    public init(
        title: String,
        dateRange: String,
        durationText: String,
        status: DSStatus,
        primaryTitle: String,
        secondaryTitle: String?,
        onClose: @escaping () -> Void,
        onPrimary: @escaping () -> Void,
        onSecondary: (() -> Void)?,
        onStatusChanged: @escaping (DSStatus) -> Void
    ) {
        self.title = title
        self.dateRange = dateRange
        self.durationText = durationText
        self.status = status
        self.primaryTitle = primaryTitle
        self.secondaryTitle = secondaryTitle
        self.onClose = onClose
        self.onPrimary = onPrimary
        self.onSecondary = onSecondary
        self.onStatusChanged = onStatusChanged
    }
}
