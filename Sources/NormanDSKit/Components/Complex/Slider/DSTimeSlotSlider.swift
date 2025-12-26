//
//  DSTimeSlotSlider.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

public struct DSTimeSlotSlider: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let slots: [String]
    @Binding private var selectedIndex: Int

    public init(slots: [String], selectedIndex: Binding<Int>) {
        self.slots = slots
        self._selectedIndex = selectedIndex
    }

    public var body: some View {
        VStack(spacing: theme.spacing.sm) {
            Slider(
                value: Binding(
                    get: { Double(selectedIndex) },
                    set: { selectedIndex = Int(round($0)).clamped(to: 0...(slots.count - 1)) }
                ),
                in: 0...Double(max(0, slots.count - 1)),
                step: 1
            )
            .tint(theme.colors.primary.resolved(scheme))
            .accessibilityLabel("Time")

            HStack {
                ForEach(slots.indices, id: \.self) { idx in
                    Text(slots[idx])
                        .font(idx == selectedIndex ? .caption.weight(.semibold) : .caption2)
                        .foregroundStyle(
                            idx == selectedIndex
                            ? theme.colors.textBody.resolved(scheme)
                            : theme.colors.textCaption.resolved(scheme)
                        )
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

private extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
