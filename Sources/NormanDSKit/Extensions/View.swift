//
//  View.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// Presents a design-system dialog on top of the current view hierarchy.
///
/// Use this modifier to overlay a design-system dialog (`DSDialogHost`) when `isPresented` is `true`.
/// The dialog is dismissed when the binding becomes `false`, or when the provided `onDismiss` closure
/// is invoked.
///
/// - Parameters:
///   - isPresented: A binding that controls whether the dialog is visible.
///   - onDismiss: An optional closure executed when the dialog is dismissed.
///   - content: A view builder that produces the dialog content.
/// - Returns: A view that conditionally overlays a dialog host.
///
/// ## Example
/// ```swift
/// @State private var showDialog = false
///
/// VStack {
///     Button("Show dialog") { showDialog = true }
/// }
/// .dsDialog(isPresented: $showDialog) {
///     DSDialog(
///         title: "Example",
///         subtitle: "Hello",
///         primaryButtonTitle: "OK",
///         onClose: { showDialog = false },
///         onPrimaryAction: { showDialog = false }
///     ) { Text("Content") }
/// }
/// ```
public extension View {
    /// Presents a design-system dialog on top of the current view hierarchy.
    /// - Parameters:
    ///   - isPresented: A binding that controls whether the dialog is visible.
    ///   - onDismiss: An optional closure executed when the dialog is dismissed.
    ///   - content: A builder that provides the dialog content.
    /// - Returns: A view that conditionally overlays a dialog host.
    func dsDialog<DialogContent: View>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> DialogContent
    ) -> some View {
        ZStack {
            self
            
            DSDialogHost(
                isPresented: isPresented,
                onDismiss: onDismiss,
                dialogContent: content
            )
        }
    }
}

/// Applies a system glass effect when available on the current OS.
///
/// On supported platforms (iOS 26 and later), this modifier applies the system glass effect.
/// On earlier versions, the original view is returned unchanged.
///
/// - Returns: A view with a glass effect on iOS 26 and later; otherwise the original view.
///
/// ## Availability
/// - iOS 26+
///
/// ## Example
/// ```swift
/// RoundedRectangle(cornerRadius: 16)
///     .fill(.ultraThinMaterial)
///     .mcGlassEffectIfAvailable()
/// ```
public extension View {
    /// Applies a system glass effect when available on the current OS.
    /// - Returns: A view with glass effect on iOS 26 and later, otherwise the original view.
    @ViewBuilder
    func mcGlassEffectIfAvailable() -> some View {
        if #available(iOS 26, *) {
            self.glassEffect()
        } else {
            self
        }
    }
}


public extension View {
    func mcGlassBackground<S: InsettableShape>(
        in shape: S,
        tint: Color? = nil,
        tintOpacity: Double = 0.12,
        stroke: Color = .white,
        strokeOpacity: Double = 0.16,
        lineWidth: Double = 1
    ) -> some View {
        self.background {
            ZStack {
                if #available(iOS 26, *) {
                    Rectangle()
                        .fill(Color.white.opacity(0.001))
                        .mask(shape)
                } else {
                    shape.fill(.regularMaterial)
                }

                if let tint {
                    shape.fill(tint.opacity(tintOpacity))
                }

                shape.strokeBorder(stroke.opacity(strokeOpacity), lineWidth: lineWidth)
            }
            .compositingGroup()
            .allowsHitTesting(false)
        }
    }
}

/// Disables scroll clipping when available on this OS version.
///
/// On iOS 17 and later, applies `scrollClipDisabled()` to avoid clipping scrollable content.
/// On earlier versions, the original view is returned unchanged.
///
/// - Returns: A view with scroll clipping disabled when available.
///
/// ## Availability
/// - iOS 17+
///
/// ## Example
/// ```swift
/// ScrollView {
///     // content
/// }
/// .applyScrollClipDisabledIfAvailable()
/// ```
extension View {
    /// Disables scroll clipping on iOS 17 and later, otherwise returns the original view.
    /// - Returns: A view with `scrollClipDisabled()` applied when available.
    @ViewBuilder
    func applyScrollClipDisabledIfAvailable() -> some View {
        if #available(iOS 17.0, *) {
            self.scrollClipDisabled()
        } else {
            self
        }
    }
}

/// Styles the provided `Text` with optional bold weight.
///
/// - Parameters:
///   - text: The `Text` to style.
///   - isBold: A Boolean value that indicates whether to apply bold weight.
/// - Returns: The styled text view.
///
/// ## Example
/// ```swift
/// styledText(Text("Hello"), isBold: true)
/// ```
extension View {
    /// Styles a `Text` view based on the `isBold` flag.
    /// - Parameters:
    ///   - text: The `Text` to style.
    ///   - isBold: Whether to apply bold weight.
    /// - Returns: The styled text view.
    @ViewBuilder
    func styledText(_ text: Text, isBold: Bool) -> some View {
        if isBold {
            text.bold()
        } else {
            text
        }
    }
}

/// Hides the default scroll and text editor background when available.
///
/// On iOS 16 and later, applies `.scrollContentBackground(.hidden)`. On earlier versions,
/// the original view is returned unchanged.
///
/// - Returns: A view with scroll content background hidden when available.
///
/// ## Availability
/// - iOS 16+
///
/// ## Example
/// ```swift
/// ScrollView {
///     // content
/// }
/// .dsHideScrollContentBackground()
/// ```
public extension View {
    /// Hides the default scroll/text-editor background when available (iOS 16+).
    @ViewBuilder
    func dsHideScrollContentBackground() -> some View {
        if #available(iOS 16.0, *) {
            self.scrollContentBackground(.hidden)
        } else {
            self
        }
    }
}

/// Applies a symbol replacement transition when available.
///
/// On iOS 17 and later, uses `.contentTransition(.symbolEffect(.replace))`.
/// On iOS 16, falls back to `.contentTransition(.opacity)`.
/// On earlier versions, returns the original view.
///
/// - Returns: A view with a symbol replacement transition when available.
///
/// ## Availability
/// - iOS 17+ for symbol effect
/// - iOS 16+ fallback to opacity
///
/// ## Example
/// ```swift
/// Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
///     .symbolReplaceTransitionIfAvailable()
/// ```
public extension View {
    @ViewBuilder
    func symbolReplaceTransitionIfAvailable() -> some View {
        if #available(iOS 17.0, *) {
            self.contentTransition(.symbolEffect(.replace))
        } else if #available(iOS 16.0, *) {
            self.contentTransition(.opacity) // fallback decente
        } else {
            self
        }
    }
}

public enum MCSheetDetent: Hashable {
    case medium
    case large
}

public extension View {
    /// Applies modern sheet presentation APIs when available (iOS 16+).
    ///
    /// This modifier maps the custom `MCSheetDetent` values to system detents and applies
    /// `.presentationDetents` and `.presentationDragIndicator` where available.
    ///
    /// - Parameters:
    ///   - detents: The sheet detents to use. Defaults to `[.medium, .large]`.
    ///   - dragIndicatorVisible: Whether the sheet drag indicator is visible. Defaults to `true`.
    /// - Returns: A view with modern sheet presentation configuration when available.
    ///
    /// ## Availability
    /// - iOS 16+
    ///
    /// ## Example
    /// ```swift
    /// .sheet(isPresented: $isPresented) {
    ///     Content()
    ///         .mcPresentationIfAvailable(detents: [.medium, .large], dragIndicatorVisible: true)
    /// }
    /// ```
    @ViewBuilder
    func mcPresentationIfAvailable(
        detents: [MCSheetDetent] = [.medium, .large],
        dragIndicatorVisible: Bool = true
    ) -> some View {
        if #available(iOS 16.0, *) {
            self
                .presentationDetents(Set(detents.map { $0._toSystem() }))
                .presentationDragIndicator(dragIndicatorVisible ? .visible : .hidden)
        } else {
            self
        }
    }
}

@available(iOS 16.0, *)
private extension MCSheetDetent {
    func _toSystem() -> PresentationDetent {
        switch self {
        case .medium: return .medium
        case .large: return .large
        }
    }
}

public extension View {
    /// Sets the sheet presentation background color when available.
    ///
    /// On iOS 16.4 and later, applies `.presentationBackground(_:)` to the view.
    /// On earlier versions, the original view is returned unchanged.
    ///
    /// - Parameter color: The background color to apply.
    /// - Returns: A view with the presentation background color applied when available.
    ///
    /// ## Availability
    /// - iOS 16.4+
    ///
    /// ## Example
    /// ```swift
    /// .sheet(isPresented: $isPresented) {
    ///     Content()
    ///         .presentationBackgroundIfAvailable(.black.opacity(0.6))
    /// }
    /// ```
    @ViewBuilder
    func presentationBackgroundIfAvailable(_ color: Color) -> some View {
        if #available(iOS 16.4, *) {
            self.presentationBackground(color)
        } else {
            self
        }
    }
}

public extension View {
    /// Applies a submit label to the text input when one is provided.
    /// - Parameter label: The optional `SubmitLabel` to apply.
    /// - Returns: A view with the appropriate submit label applied when available.
    @ViewBuilder
    func applySubmitLabelIfNeeded(_ label: SubmitLabel?) -> some View {
        if let label {
            self.submitLabel(label)
        } else {
            self
        }
    }
}
