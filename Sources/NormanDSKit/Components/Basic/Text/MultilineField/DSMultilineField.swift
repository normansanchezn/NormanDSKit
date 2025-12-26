//
//  DSMultilineField.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A design-system multiline text field with themed styling and validation states.
///
/// `DSMultilineField` displays a `TextEditor` with a pill-style label, helper/error
/// messaging, and focus/validation-aware borders using the current theme.
///
/// ### Example
/// ```swift
/// @State private var notes = ""
///
/// var body: some View {
///     DSMultilineField(
///         model: DSMultilineFieldModel(
///             label: DSLabelModel(text: "Notes", style: .overline, isBold: true),
///             helperText: "Add more details if needed"
///         ),
///         text: $notes
///     )
/// }
/// ```
public struct DSMultilineField: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    @Binding private var text: String
    private let model: DSMultilineFieldModel
    
    @FocusState private var isFocused: Bool
    
    /// Creates a multiline design-system text field.
    /// - Parameters:
    ///   - model: The configuration describing label, helper/error text, sizing, and state.
    ///   - text: A binding to the field's text content.
    public init(
        model: DSMultilineFieldModel,
        text: Binding<String>
    ) {
        self.model = model
        self._text = text
    }
    
    /// The content and layout of the multiline field.
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
    
    /// Displays helper text in normal state or error text in error state, styled by theme.
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
    
    /// Resolves the background color for the text editor based on enabled and theme state.
    private var fieldBackgroundColor: Color {
        if !model.isEnabled {
            return theme.colors.surfaceSecondary
                .resolved(scheme)
                .opacity(0.8)
        }
        return theme.colors.surfaceSecondary.resolved(scheme)
    }
    
    /// Resolves the text color for the text editor.
    private var fieldTextColor: Color {
        theme.colors.textBody.resolved(scheme)
    }
    
    /// Resolves the border color, reflecting focus and validation state.
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

