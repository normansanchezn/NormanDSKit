//
//  DSMultilineField.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSMultilineField: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    @Binding private var text: String
    private let model: DSMultilineFieldModel
    
    @FocusState private var isFocused: Bool
    
    public init(
        model: DSMultilineFieldModel,
        text: Binding<String>
    ) {
        self.model = model
        self._text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            
            // Label superior (estilo Liquid Glass: pill suave)
            DSLabel(model.label)
                .padding(.horizontal, theme.spacing.lg)
                .padding(.vertical, theme.spacing.xs)
                .background(
                    RoundedRectangle(cornerRadius: theme.radius.lg)
                        .fill(
                            theme.colors.surface.resolved(scheme)
                                .opacity(theme.opacity.glassBackground)
                        )
                )
                .padding(.top, theme.spacing.xs)
            
            // Campo multilinea
            TextEditor(text: $text)
                .focused($isFocused)
                .disabled(!model.isEnabled)
                .padding(theme.spacing.md)
                .frame(minHeight: model.minHeight)
                .background(
                    RoundedRectangle(cornerRadius: theme.radius.md)
                        .fill(fieldBackgroundColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radius.md)
                        .stroke(
                            borderColor,
                            lineWidth: 1
                        )
                )
                .foregroundColor(fieldTextColor)
                .font(theme.typography.body.font)
                .opacity(model.isEnabled ? 1.0 : theme.opacity.disabled)
                .padding(.horizontal, theme.spacing.xs)
            
            helperOrErrorText
        }
    }
    
    // MARK: - Helper / Error
    
    @ViewBuilder
    private var helperOrErrorText: some View {
        switch model.state {
        case .error:
            if let error = model.errorText, !error.isEmpty {
                Text(error)
                    .font(theme.typography.caption.font)
                    .foregroundColor(theme.colors.error.resolved(scheme))
                    .padding(.horizontal, theme.spacing.xs)
            }
        default:
            if let helper = model.helperText, !helper.isEmpty {
                Text(helper)
                    .font(theme.typography.caption.font)
                    .foregroundColor(theme.colors.textCaption.resolved(scheme))
                    .padding(.horizontal, theme.spacing.xs)
            }
        }
    }
    
    // MARK: - Colors (LiquidGlass style)
    
    private var fieldBackgroundColor: Color {
        if !model.isEnabled {
            return theme.colors.surfaceSecondary
                .resolved(scheme)
                .opacity(0.8)
        }
        return theme.colors.surfaceSecondary.resolved(scheme)
    }
    
    private var fieldTextColor: Color {
        theme.colors.textBody.resolved(scheme)
    }
    
    private var borderColor: Color {
        if !model.isEnabled {
            return theme.colors.textCaption
                .resolved(scheme)
                .opacity(theme.opacity.disabled)
        }
        
        switch model.state {
        case .error:
            return theme.colors.error.resolved(scheme)
        case .success:
            return theme.colors.success.resolved(scheme)
        case .normal:
            if isFocused {
                return theme.colors.primary.resolved(scheme)
            } else {
                return theme.colors.onBackground
                    .resolved(scheme)
                    .opacity(theme.opacity.subtle)
            }
        }
    }
}
