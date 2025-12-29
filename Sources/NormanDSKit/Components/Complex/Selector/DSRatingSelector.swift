//
//  DSRatingSelector.swift
//  NormanDSKit
//
//  Created by Norman on 28/12/25.
//
import SwiftUI

import SwiftUI

public struct DSRatingSelector: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let title: DSLabelModel?
    private let max: Int
    @Binding private var value: Int

    public init(
        title: DSLabelModel? = nil,
        max: Int = 5,
        value: Binding<Int>
    ) {
        self.title = title
        self.max = max
        self._value = value
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            if let title { DSLabel(title) }

            HStack(spacing: theme.spacing.sm) {
                ForEach(1...max, id: \.self) { index in
                    Button {
                        value = index
                    } label: {
                        Image(systemName: index <= value ? "star.fill" : "star")
                            .symbolRenderingMode(.hierarchical)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(
                                index <= value
                                ? theme.colors.primary.resolved(scheme)
                                : theme.colors.textCaption.resolved(scheme)
                            )
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: theme.radius.md)
                                    .fill(theme.colors.surfaceSecondary.resolved(scheme).opacity(0.6))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
