//
//  DSField.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A design-system text input field with optional label, helper, and error states.
///
/// `DSField` encapsulates a configurable text input that adapts to the current
/// design system theme and color scheme. It supports secure entry, submit labels,
/// and validation states (normal, success, error) that affect border and helper text.
///
/// Use this view when you need a consistent text field appearance and behavior across
/// your app, including placeholder, helper text, and error messaging.
///
/// - Important: `DSField` reads design values from the environment (theme, colors,
///   spacing, typography). Make sure your view hierarchy provides the expected
///   environment values.
///
/// ### Example
///
/// ```swift
/// @State private var email = ""
///
/// var body: some View {
///     DSField(
///         model: DSFieldModel(
///             placeholder: "Email",
///             label: .init(text: "Your email"),
///             helperText: "We will never share your email.",
///             state: .normal
///         ),
///         text: $email
///     )
/// }
/// ```
public struct DSField: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    /// The configuration model that defines appearance, behavior, and state
    /// (e.g., placeholder, label, helper text, keyboard type, and validation state).
    public let model: DSFieldModel
    /// The bound text value displayed and edited by the field.
    ///
    /// - Note: Changes to this binding are reflected by the field and propagated
    ///   back to the source of truth.
    @Binding public var text: String
    private let inputTransform: ((String) -> String)?

    @FocusState private var isFocused: Bool
    
    /// Creates a new design-system text field.
    ///
    /// - Parameters:
    ///   - model: The design-system configuration that controls the field's look and behavior.
    ///   - text: A binding to the text the field displays and edits.
    public init(
        model: DSFieldModel,
        text: Binding<String>,
        inputTransform: ((String) -> String)? = nil
    ) {
        self.model = model
        self._text = text
        self.inputTransform = inputTransform
    }
    
    /// The content and layout of the field.
    ///
    /// This view composes the optional label, the input field, and helper or error text
    /// using the current design-system theme.
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
    
    /// The underlying SwiftUI text input control (secure or plain) configured with
    /// keyboard, content type, autocapitalization, and autocorrection options.
    @ViewBuilder
    private var inputField: some View {
        let prompt = Text(model.placeholder)
            .foregroundColor(
                theme.colors.onSecondary.resolved(scheme)
                    .opacity(theme.opacity.glassBorder)
            )

        let sanitizedBinding = Binding<String>(
            get: { text },
            set: { newValue in
                let transformed = inputTransform?(newValue) ?? newValue
                if transformed != text {
                    text = transformed
                } else {
                    text = newValue
                }
            }
        )

        Group {
            if model.isSecure {
                SecureField(model.placeholder, text: sanitizedBinding, prompt: prompt)
                    .foregroundColor(theme.colors.onTextEntry.resolved(scheme))
            } else {
                TextField(model.placeholder, text: sanitizedBinding, prompt: prompt)
                    .foregroundColor(theme.colors.onTextEntry.resolved(scheme))
            }
        }
        .keyboardType(model.keyboardType)
        .textContentType(model.textContentType)
        .textInputAutocapitalization(model.autocapitalization)
        .autocorrectionDisabled(model.autocorrectionDisabled)
    }
    
    /// Displays helper text in normal state, or error text in error state, styled
    /// according to the current theme.
    @ViewBuilder
    private var helperOrErrorText: some View {
        switch model.state {
        case .error:
            if let error = model.errorText, !error.isEmpty {
                Text(error)
                    .font(theme.typography.caption.font)
                    .foregroundColor(theme.colors.error.resolved(scheme))
                    .padding(.horizontal, theme.spacing.md)
            }
        default:
            if let helper = model.helperText, !helper.isEmpty {
                Text(helper)
                    .font(theme.typography.caption.font)
                    .foregroundColor(theme.colors.textCaption.resolved(scheme))
                    .padding(.horizontal, theme.spacing.md)
            }
        }
    }
    
    /// Resolves the background color for the field based on the current state and theme.
    private var fieldBackgroundColor: Color {
        if !model.isEnabled {
            return theme.colors.surfaceSecondary
                .resolved(scheme)
                .opacity(0.8)
        }
        return theme.colors.surfaceSecondary.resolved(scheme)
    }
    
    /// Resolves the border color for the field, highlighting focus, success, or error states.
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
                return theme.colors.onSecondary
                    .resolved(scheme)
                    .opacity(theme.opacity.subtle)
            }
        }
    }
}
