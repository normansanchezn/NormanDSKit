//
//  DSFieldModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model for `DSField` that defines appearance, behavior, and state.
///
/// Use `DSFieldModel` to describe how a design-system text field should render and
/// behave, including its placeholder, optional label, helper and error text, input
/// traits (keyboard type, content type), and validation state.
///
/// ### Example
///
/// ```swift
/// let model = DSFieldModel(
///     label: .init(text: "Email"),
///     placeholder: "name@example.com",
///     helperText: "We'll never share your email.",
///     state: .normal,
///     keyboardType: .emailAddress,
///     textContentType: .emailAddress
/// )
/// ```
public struct DSFieldModel {
    /// Represents the validation/visual state of the field.
    ///
    /// - normal: The default, neutral state.
    /// - success: Indicates a successful/valid input.
    /// - error: Indicates an invalid input; the field may display an error message.
    public enum State {
        case normal
        case success
        case error
    }
    
    /// An optional label model rendered above the input field.
    public let label: DSLabelModel?
    /// The placeholder text displayed when the field is empty.
    public let placeholder: String
    /// Optional helper text shown in the normal state to guide the user.
    public let helperText: String?
    /// Optional error text shown when `state` is `.error`.
    public let errorText: String?
    /// The minimum height of the input area, in points. Defaults to 44.
    public let minHeight: CGFloat
    /// A Boolean value that indicates whether the field is enabled for input.
    public let isEnabled: Bool
    /// The current validation/visual state for the field.
    public let state: State
    /// The keyboard type to use for text entry. Defaults to `.default`.
    public var keyboardType: UIKeyboardType
    /// The semantic content type used to improve keyboard and autofill behavior.
    public var textContentType: UITextContentType?
    /// The submit label to display on the keyboard, if any (e.g., `.done`, `.go`).
    public var submitLabel: SubmitLabel?
    /// The autocapitalization behavior for the text input.
    public var autocapitalization: TextInputAutocapitalization?
    /// A Boolean value that indicates whether autocorrection is disabled.
    public var autocorrectionDisabled: Bool
    /// Whether the field should obscure input (secure entry).
    public var isSecure: Bool
    
    /// Creates a new field model.
    ///
    /// - Parameters:
    ///   - label: An optional label model shown above the field.
    ///   - placeholder: The placeholder text displayed when empty.
    ///   - helperText: Optional helper guidance shown in normal state.
    ///   - errorText: Optional error text shown when `state` is `.error`.
    ///   - minHeight: The minimum height of the input area. Default is 44.
    ///   - isEnabled: Whether the field is enabled for input. Default is `true`.
    ///   - state: The visual/validation state. Default is `.normal`.
    ///   - keyboardType: The keyboard type for text entry. Default is `.default`.
    ///   - textContentType: The semantic text content type for autofill.
    ///   - submitLabel: The keyboard submit label (e.g., `.done`).
    ///   - autocapitalization: The text autocapitalization behavior.
    ///   - autocorrectionDisabled: Whether to disable autocorrection. Default is `false`.
    ///   - isSecure: Whether input is obscured (secure entry). Default is `false`.
    public init(
        label: DSLabelModel? = nil,
        placeholder: String,
        helperText: String? = nil,
        errorText: String? = nil,
        minHeight: CGFloat = 44,
        isEnabled: Bool = true,
        state: State = .normal,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        submitLabel: SubmitLabel? = nil,
        autocapitalization: TextInputAutocapitalization? = nil,
        autocorrectionDisabled: Bool = false,
        isSecure: Bool = false
    ) {
        self.label = label
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorText = errorText
        self.minHeight = minHeight
        self.isEnabled = isEnabled
        self.state = state
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.submitLabel = submitLabel
        self.autocapitalization = autocapitalization
        self.autocorrectionDisabled = autocorrectionDisabled
        self.isSecure = isSecure
    }
}

