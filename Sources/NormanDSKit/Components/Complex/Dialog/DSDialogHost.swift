//
//  DSDialogHost.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A lightweight host that presents a custom dialog over a dimmed backdrop.
///
/// `DSDialogHost` renders an overlay with a dimmed background and centers the
/// provided dialog content when `isPresented` is `true`. Tapping the backdrop
/// dismisses the dialog and invokes `onDismiss` if provided.
///
/// - Generics:
///   - `DialogContent`: The SwiftUI view used as the dialog content.
///
/// ### Example
/// ```swift
/// @State private var isPresented = false
///
/// DSDialogHost(isPresented: $isPresented) {
///     DSDialog(
///         title: "Confirm",
///         primaryButtonTitle: "OK",
///         onClose: { isPresented = false },
///         onPrimaryAction: { isPresented = false }
///     ) {
///         Text("Are you sure?")
///     }
/// }
/// ```
///
/// - Parameters:
///   - isPresented: A binding that controls whether the dialog is visible.
///   - onDismiss: An optional closure called after the dialog is dismissed.
///   - dialogContent: A builder that returns the dialog view to present.
///
/// - Environment:
///   - dsTheme: Design system theme used for spacing, colors, and radii.
///   - colorScheme: The current color scheme (light/dark) used to resolve colors.
public struct DSDialogHost<DialogContent: View>: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    @Binding private var isPresented: Bool
    private let onDismiss: (() -> Void)?
    private let dialogContent: () -> DialogContent
    
    public init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.dialogContent = dialogContent
    }
    
    public var body: some View {
        ZStack {
            if isPresented {
                // Fondo oscurecido
                Color.black
                    .opacity(theme.opacity.overlay)
                    .ignoresSafeArea()
                    .onTapGesture {
                        dismiss()
                    }
                    .transition(.opacity)
                
                // Dialog centrado
                dialogContent()
                    .transition(
                        .asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        )
                    )
                    .zIndex(1)
            }
        }
        // Animación global de aparición / desaparición
        .animation(.spring(response: 0.3, dampingFraction: 0.85), value: isPresented)
        .zIndex(1000) // por encima del resto de la UI
    }
    
    private func dismiss() {
        isPresented = false
        onDismiss?()
    }
}
