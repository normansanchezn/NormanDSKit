//
//  DSRoundedImage.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSRoundedImage: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let model: DSRoundedImageModel
    
    public init(_ model: DSRoundedImageModel) {
        self.model = model
    }
    
    public var body: some View {
        AsyncImage(url: URL(string: model.imageURL)) { phase in
            switch phase {
            case .empty:
                placeholder
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                errorPlaceholder

            @unknown default:
                errorPlaceholder
            }
        }
        .frame(width: model.size, height: model.size)
        .clipShape(
            RoundedRectangle(
                cornerRadius: model.cornerRadius,
                style: .continuous
            )
        )
        .background(backgroundGlass)
        .overlay(
            RoundedRectangle(cornerRadius: model.cornerRadius, style: .continuous)
                .stroke(
                    theme.colors.surfaceSecondary
                        .resolved(scheme)
                        .opacity(theme.opacity.subtle),
                    lineWidth: 1
                )
        )
        .contentShape(Rectangle())
    }
    
    // MARK: - Background
    
    private var backgroundGlass: some View {
        Group {
            if model.showsGlassBackground {
                RoundedRectangle(
                    cornerRadius: model.cornerRadius,
                    style: .continuous
                )
                .fill(.ultraThinMaterial)
                .background(
                    theme.colors.surface
                        .resolved(scheme)
                        .opacity(theme.opacity.glassBackground)
                )
            } else {
                Color.clear
            }
        }
    }
    
    // MARK: - Placeholder
    
    private var placeholder: some View {
        RoundedRectangle(
            cornerRadius: model.cornerRadius,
            style: .continuous
        )
        .fill(
            theme.colors.surfaceSecondary
                .resolved(scheme)
                .opacity(theme.opacity.tinted)
        )
        .overlay(
            ProgressView()
                .tint(
                    theme.colors.primary.resolved(scheme)
                )
        )
    }
    
    // MARK: - Error Placeholder
    
    private var errorPlaceholder: some View {
        RoundedRectangle(
            cornerRadius: model.cornerRadius,
            style: .continuous
        )
        .fill(
            theme.colors.error.resolved(scheme).opacity(0.12)
        )
        .overlay(
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: model.size * 0.3))
                .foregroundColor(
                    theme.colors.error.resolved(scheme)
                )
        )
    }
}
