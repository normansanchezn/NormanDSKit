//
//  View.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public extension View {
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

public extension View {
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
    @ViewBuilder
    func styledText(_ text: Text, isBold: Bool) -> some View {
        if isBold {
            text.bold()
        } else {
            text
        }
    }
}
