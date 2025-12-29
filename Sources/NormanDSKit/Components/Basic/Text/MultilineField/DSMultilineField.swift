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
import SwiftUI

public struct DSMultilineField: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    @Binding private var text: String
    @FocusState private var isFocused: Bool

    private enum BackingModel {
        case multiline(DSMultilineFieldModel)
        case field(DSFieldModel)
    }

    private let backing: BackingModel

    // ✅ INIT EXISTENTE (no rompe llamadas actuales)
    public init(
        model: DSMultilineFieldModel,
        text: Binding<String>
    ) {
        self.backing = .multiline(model)
        self._text = text
    }

    public init(
        model: DSFieldModel,
        text: Binding<String>
    ) {
        self.backing = .field(model)
        self._text = text
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {

            if let labelModel = resolvedLabel {
                DSLabel(labelModel)
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
                    .padding(.top, theme.spacing.xs)
            }

            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .dsHideScrollContentBackground()
                    .background(Color.clear)
                    .contentShape(Rectangle())
                    .focused($isFocused)
                    .disabled(!resolvedIsEnabled)
                    .keyboardType(resolvedKeyboardType)
                    .textContentType(resolvedTextContentType)
                    .textInputAutocapitalization(resolvedAutocapitalization)
                    .autocorrectionDisabled(resolvedAutocorrectionDisabled)
                    .foregroundColor(theme.colors.textBody.resolved(scheme))
                    .font(theme.typography.body.font)
                    .opacity(resolvedIsEnabled ? 1.0 : theme.opacity.disabled)
                    .padding(theme.spacing.md)
                    .frame(minHeight: resolvedMinHeight)
                    .overlay(alignment: .topLeading) {
                            if text.isEmpty, let placeholder = resolvedPlaceholder, !placeholder.isEmpty {
                                DSLabel(.init(
                                    text: placeholder,
                                    style: .body,
                                    textColor: theme.colors.textCaption.resolved(scheme)
                                ))
                                .padding(.leading, theme.spacing.md + 5)
                                .padding(.top, theme.spacing.md + 8)
                                .allowsHitTesting(false)
                            }
                        }
            }
            .background(
                RoundedRectangle(cornerRadius: theme.radius.md)
                    .fill(fieldBackgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.radius.md)
                    .stroke(borderColor, lineWidth: 1)
            )
            .padding(.horizontal, theme.spacing.xs)

            helperOrErrorText
        }
    }

    // MARK: - Unified resolved props
    private var resolvedLabel: DSLabelModel? {
        switch backing {
        case .multiline(let m):
            return m.label
        case .field(let m):
            return m.label
        }
    }

    private var resolvedPlaceholder: String? {
        switch backing {
        case .multiline:
            return nil
        case .field(let m):
            return m.placeholder
        }
    }

    private var resolvedHelperText: String? {
        switch backing {
        case .multiline(let m):
            return m.helperText
        case .field(let m):
            return m.helperText
        }
    }

    private var resolvedErrorText: String? {
        switch backing {
        case .multiline(let m):
            return m.errorText
        case .field(let m):
            return m.errorText
        }
    }

    private var resolvedMinHeight: CGFloat {
        switch backing {
        case .multiline(let m):
            return m.minHeight
        case .field(let m):
            return m.minHeight
        }
    }

    private var resolvedIsEnabled: Bool {
        switch backing {
        case .multiline(let m): return m.isEnabled
        case .field(let m): return m.isEnabled
        }
    }

    private enum UnifiedState { case normal, success, error }

    private var resolvedState: UnifiedState {
        switch backing {
        case .multiline(let m):
            switch m.state {
            case .normal: return .normal
            case .success: return .success
            case .error: return .error
            }
        case .field(let m):
            switch m.state {
            case .normal: return .normal
            case .success: return .success
            case .error: return .error
            }
        }
    }

    private var resolvedKeyboardType: UIKeyboardType {
        switch backing {
        case .multiline:
            return .default
        case .field(let m):
            return m.keyboardType
        }
    }

    private var resolvedTextContentType: UITextContentType? {
        switch backing {
        case .multiline:
            return nil
        case .field(let m):
            return m.textContentType
        }
    }

    private var resolvedAutocapitalization: TextInputAutocapitalization {
        switch backing {
        case .multiline:
            return .sentences
        case .field(let m):
            return m.autocapitalization!
        }
    }

    private var resolvedAutocorrectionDisabled: Bool {
        switch backing {
        case .multiline:
            return false
        case .field(let m):
            return m.autocorrectionDisabled
        }
    }

    // MARK: - Helper / Error
    @ViewBuilder
    private var helperOrErrorText: some View {
        switch resolvedState {
        case .error:
            if let error = resolvedErrorText, !error.isEmpty {
                DSLabel(.init(
                    text: error,
                    style: .caption,
                    textColor: theme.colors.error.resolved(scheme)
                ))
                .padding(.horizontal, theme.spacing.xs)
            }
        default:
            if let helper = resolvedHelperText, !helper.isEmpty {
                DSLabel(.init(
                    text: helper,
                    style: .caption,
                    textColor: theme.colors.textCaption.resolved(scheme)
                ))
                .padding(.horizontal, theme.spacing.xs)
            }
        }
    }

    // MARK: - Colors

    private var fieldBackgroundColor: Color {
        if !resolvedIsEnabled {
            return theme.colors.surfaceSecondary.resolved(scheme).opacity(0.8)
        }
        return theme.colors.surfaceSecondary.resolved(scheme)
    }

    private var borderColor: Color {
        if !resolvedIsEnabled {
            return theme.colors.textCaption
                .resolved(scheme)
                .opacity(theme.opacity.disabled)
        }

        switch resolvedState {
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
