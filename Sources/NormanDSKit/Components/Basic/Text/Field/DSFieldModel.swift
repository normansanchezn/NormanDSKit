//
//  DSFieldModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSFieldModel {
    public enum State {
        case normal
        case success
        case error
    }
    
    public let label: DSLabelModel?
    public let placeholder: String
    public let helperText: String?
    public let errorText: String?
    public let minHeight: CGFloat
    public let isEnabled: Bool
    public let state: State
    
    public init(
        label: DSLabelModel? = nil,
        placeholder: String,
        helperText: String? = nil,
        errorText: String? = nil,
        minHeight: CGFloat = 44,
        isEnabled: Bool = true,
        state: State = .normal
    ) {
        self.label = label
        self.placeholder = placeholder
        self.helperText = helperText
        self.errorText = errorText
        self.minHeight = minHeight
        self.isEnabled = isEnabled
        self.state = state
    }
}
