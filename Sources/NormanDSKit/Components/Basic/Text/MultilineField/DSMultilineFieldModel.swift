//
//  DSMultilineFieldModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model for `DSMultilineField`, defining label, helper/error text,
/// sizing, enabled state, and validation state.
///
/// ### Example
/// ```swift
/// let model = DSMultilineFieldModel(
///     label: DSLabelModel(text: "Description", style: .overline, isBold: true),
///     helperText: "Provide as many details as you can.",
///     minHeight: 140
/// )
/// ```
public struct DSMultilineFieldModel {
    
    /// Represents the validation/visual state of the multiline field.
    /// - normal: Neutral, default state.
    /// - success: Indicates valid input.
    /// - error: Indicates invalid input and may display `errorText`.
    public enum State {
        case normal
        case success
        case error
    }
    
    /// The label shown above the text editor.
    public let label: DSLabelModel
    
    /// Optional helper text shown when the state is not `.error`.
    public let helperText: String?
    
    /// Optional error text shown when the state is `.error`.
    public let errorText: String?
    
    /// The minimum height for the text editor area. Default is 120.
    public let minHeight: CGFloat
    
    /// A Boolean value indicating whether the field is enabled for input.
    public let isEnabled: Bool
    
    /// The current validation/visual state.
    public let state: State
    
    /// Creates a multiline field model.
    /// - Parameters:
    ///   - label: The label to display above the field.
    ///   - helperText: Optional helper guidance shown in normal state.
    ///   - errorText: Optional error message shown in error state.
    ///   - minHeight: The minimum height for the editor. Default is 120.
    ///   - isEnabled: Whether the field is enabled. Default is `true`.
    ///   - state: The validation/visual state. Default is `.normal`.
    public init(
        label: DSLabelModel,
        helperText: String? = nil,
        errorText: String? = nil,
        minHeight: CGFloat = 120,
        isEnabled: Bool = true,
        state: State = .normal
    ) {
        self.label = label
        self.helperText = helperText
        self.errorText = errorText
        self.minHeight = minHeight
        self.isEnabled = isEnabled
        self.state = state
    }
}

