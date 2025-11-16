//
//  DSSelectableRow.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSSelectableRow: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    let item: DSSelectionItem
    let isSelected: Bool
    
    public init(item: DSSelectionItem, isSelected: Bool) {
        self.item = item
        self.isSelected = isSelected
    }
    
    public var body: some View {
        HStack(spacing: theme.spacing.md) {
            
            if let icon = item.icon {
                Image(systemName: icon)
                    .foregroundColor(theme.colors.primary.resolved(scheme))
                    .font(.system(size: 18, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: theme.spacing.xs / 2) {
                Text(item.title)
                    .font(theme.typography.body.font)
                    .foregroundColor(theme.typography.body.color.resolved(scheme))
                
                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .font(theme.typography.caption.font)
                        .foregroundColor(theme.typography.caption.color.resolved(scheme))
                }
            }
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(theme.colors.primary.resolved(scheme))
            }
        }
        .padding(theme.spacing.md)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.md)
                .fill(
                    theme.colors.surface
                        .resolved(scheme)
                        .opacity(
                            isSelected
                            ? theme.opacity.glassBackground
                            : theme.opacity.tinted
                        )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radius.md)
                .stroke(
                    isSelected
                    ? theme.colors.primary.resolved(scheme)
                    : theme.colors.onBackground.resolved(scheme).opacity(theme.opacity.subtle),
                    lineWidth: isSelected ? 2 : 1
                )
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.85), value: isSelected)
    }
}
