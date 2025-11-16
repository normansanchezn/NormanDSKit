//
//  DSDialogHost.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

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
