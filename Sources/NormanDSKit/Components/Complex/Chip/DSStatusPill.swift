//
//  DSStatusPill.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import SwiftUI

public struct DSStatusPill: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    let text: String
    let status: DSStatus?

    public init(
        text: String,
        status: DSStatus? = nil
    ) {
        self.text = text
        self.status = status
    }

    @ViewBuilder
    private var backgroundCapsule: some View {
        switch status {
        case .completed:
            Capsule().fill(theme.colors.success.resolved(scheme))
        case .inProcess:
            Capsule().fill(theme.colors.secondary.resolved(scheme))
        case .started:
            Capsule().fill(theme.colors.tertiary.resolved(scheme))
        case .pending:
            Capsule().fill(theme.colors.warning.resolved(scheme))
        case nil:
            Capsule().fill(theme.colors.primary.resolved(scheme))
        }
    }

    public var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(backgroundCapsule)
    }
}

