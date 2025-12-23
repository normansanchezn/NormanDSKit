//
//  DSField.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSField: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    public let model: DSFieldModel
    @Binding public var text: String
    
    @FocusState private var isFocused: Bool
    
    public init(
        model: DSFieldModel,
        text: Binding<String>
    ) {
        self.model = model
        self._text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            if let label = model.label {
                DSLabel(label)
                    .padding(.horizontal, theme.spacing.lg)
                    .padding(.vertical, theme.spacing.xs)
                    .background(
                        RoundedRectangle(cornerRadius: theme.radius.lg)
                            .fill(
                                theme.colors.surface
                                    .resolved(scheme)
                                    .opacity(theme.opacity.glassBackground)
                            )
                    )
            }
            
            inputField
                .focused($isFocused)
                .disabled(!model.isEnabled)
                .font(theme.typography.body.font)
                .foregroundColor(theme.colors.textBody.resolved(scheme))
                .padding(.horizontal, theme.spacing.lg)
                .padding(.vertical, theme.spacing.sm)
                .frame(minHeight: model.minHeight)
                .background(
                    RoundedRectangle(cornerRadius: theme.radius.md)
                        .fill(fieldBackgroundColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radius.md)
                        .stroke(borderColor, lineWidth: 1)
                )
                .opacity(model.isEnabled ? 1 : theme.opacity.disabled)
                .applySubmitLabelIfNeeded(model.submitLabel)
            
            helperOrErrorText
        }
        .padding(.horizontal, theme.spacing.xs)
    }
    
    // MARK: - TextField
    @ViewBuilder
    private var inputField: some View {
        let prompt = Text(model.placeholder)
            .foregroundColor(theme.colors.textCaption.resolved(scheme))

        Group {
            if model.isSecure {
                SecureField(model.placeholder, text: $text, prompt: prompt)
            } else {
                TextField(model.placeholder, text: $text, prompt: prompt)
            }
        }
        .keyboardType(model.keyboardType)
        .textContentType(model.textContentType)
        .textInputAutocapitalization(model.autocapitalization)
        .autocorrectionDisabled(model.autocorrectionDisabled)
    }

    
    // MARK: - Subviews
    
    @ViewBuilder
    private var helperOrErrorText: some View {
        switch model.state {
        case .error:
            if let error = model.errorText, !error.isEmpty {
                Text(error)
                    .font(theme.typography.caption.font)
                    .foregroundColor(theme.colors.error.resolved(scheme))
            }
        default:
            if let helper = model.helperText, !helper.isEmpty {
                Text(helper)
                    .font(theme.typography.caption.font)
                    .foregroundColor(theme.colors.textCaption.resolved(scheme))
            }
        }
    }
    
    // MARK: - Colors
    
    private var fieldBackgroundColor: Color {
        if !model.isEnabled {
            return theme.colors.surfaceSecondary
                .resolved(scheme)
                .opacity(0.8)
        }
        return theme.colors.surfaceSecondary.resolved(scheme)
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

private extension View {
    @ViewBuilder
    func applySubmitLabelIfNeeded(_ label: SubmitLabel?) -> some View {
        if let label {
            self.submitLabel(label)
        } else {
            self
        }
    }
}
