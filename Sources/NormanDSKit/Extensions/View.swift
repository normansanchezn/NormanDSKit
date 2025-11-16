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
