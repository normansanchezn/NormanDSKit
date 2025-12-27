//
//  DSRoundedImage.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A rounded-corner remote image view with optional glass background.
///
/// `DSRoundedImage` loads an image from a URL using `AsyncImage`, clips it to a rounded
/// rectangle, and can show a subtle glass background and border. It is configured via
/// `DSRoundedImageModel` and adapts to the design-system theme.
///
/// ### Example
/// ```swift
/// DSRoundedImage(
///     .init(
///         imageURL: "https://example.com/photo.jpg",
///         size: 120,
///         cornerRadius: 20,
///         showsGlassBackground: true
///     )
/// )
/// ```
public struct DSRoundedImage: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    /// The configuration model describing URL, size, corner radius, and background style.
    private let model: DSRoundedImageModel
    
    /// Creates a rounded image view.
    /// - Parameter model: The configuration describing URL, size, corner radius, and background.
    public init(_ model: DSRoundedImageModel) {
        self.model = model
    }
    
    /// The content and layout of the rounded image.
    public var body: some View {
        let trimmed = model.imageURL.trimmingCharacters(in: .whitespacesAndNewlines)
        let url = URL(string: trimmed)

        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                placeholder
                    .onAppear {
                        if url == nil {
                            print("❌ Invalid URL:", trimmed)
                        }
                    }

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure(let error):
                errorPlaceholder
                    .onAppear {
                        print("❌ AsyncImage failed:", error.localizedDescription, "url:", trimmed)
                    }

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
    
    /// Optional glass-like background that blends with the theme.
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
    
    /// Placeholder shown while the image is loading.
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
    
    /// Placeholder shown when the image fails to load.
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
