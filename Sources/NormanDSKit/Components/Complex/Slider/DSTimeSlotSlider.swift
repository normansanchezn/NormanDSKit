//
//  DSTimeSlotSlider.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

/// A slider for selecting a time slot by index with labeled ticks below.
///
/// `DSTimeSlotSlider` binds to an integer index and renders a `Slider` whose range
/// matches the number of provided time slots. Labels are displayed underneath and the
/// selected label is emphasized.
///
/// ### Example
/// ```swift
/// @State private var selected = 0
/// let times = ["09:00", "09:30", "10:00", "10:30"]
///
/// DSTimeSlotSlider(slots: times, selectedIndex: $selected)
/// ```
public struct DSTimeSlotSlider: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    /// The list of time slot labels displayed below the slider.
    private let slots: [String]
    /// A binding to the currently selected index within `slots`.
    @Binding private var selectedIndex: Int

    /// Creates a time slot slider.
    /// - Parameters:
    ///   - slots: The list of time slot labels.
    ///   - selectedIndex: A binding to the currently selected slot index.
    public init(slots: [String], selectedIndex: Binding<Int>) {
        self.slots = slots
        self._selectedIndex = selectedIndex
    }

    /// The content and layout for the time slot slider.
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

/// Clamps a comparable value to a closed range.
private extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
