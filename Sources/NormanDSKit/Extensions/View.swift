//
//  View.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// Convenience helpers for presenting design-system dialogs.
///
/// This extension adds a `dsDialog` modifier that overlays a `DSDialogHost` on top of the
/// current view hierarchy when `isPresented` is `true`.
///
/// ### Example
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

/// Convenience helper for applying a glass effect on supported OS versions.
///
/// The `mcGlassEffectIfAvailable()` modifier applies the system glass effect on iOS 26
/// and falls back to the original view on earlier versions.
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

