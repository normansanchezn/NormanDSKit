//
//  DSDateCarousel.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

public struct DSDateCarousel: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let dates: [Date]
    @Binding private var selectedDate: Date
    private let dayText: (Date) -> String
    private let weekdayText: (Date) -> String
    private let onSelect: (Date) -> Void

    public init(
        dates: [Date],
        selectedDate: Binding<Date>,
        dayText: @escaping (Date) -> String,
        weekdayText: @escaping (Date) -> String,
        onSelect: @escaping (Date) -> Void = { _ in }
    ) {
        self.dates = dates
        self._selectedDate = selectedDate
        self.dayText = dayText
        self.weekdayText = weekdayText
        self.onSelect = onSelect
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: theme.spacing.sm) {
                ForEach(dates, id: \.self) { day in
                    let isSelected = Calendar.current.isDate(day, inSameDayAs: selectedDate)

                    VStack(spacing: 6) {
                        Text(dayText(day))
                            .font(.headline.weight(.bold))

                        Text(weekdayText(day))
                            .font(.caption2)
                            .foregroundStyle(theme.colors.textCaption.resolved(scheme))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .frame(width: 90, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: theme.radius.md)
                            .fill(
                                isSelected
                                ? theme.colors.primary.resolved(scheme).opacity(0.18)
                                : theme.colors.surface.resolved(scheme).opacity(0.6)
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: theme.radius.md)
                            .stroke(
                                isSelected
                                ? theme.colors.primary.resolved(scheme)
                                : theme.colors.onBackground.resolved(scheme).opacity(theme.opacity.subtle),
                                lineWidth: 1
                            )
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedDate = day
                        onSelect(day)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(isSelected ? .isSelected : [])
                }
            }
            .padding(.vertical, theme.spacing.xs)
        }
    }
}
