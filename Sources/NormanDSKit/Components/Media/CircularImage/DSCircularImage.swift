//
//  DSCircularImage.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A circular remote image view with optional border using the design system.
///
/// `DSCircularImage` loads an image from a URL using `AsyncImage`, clips it to a circle,
/// and optionally draws a border. Colors and radii adapt to the current `dsTheme` and `colorScheme`.
///
/// ### Example
/// ```swift
/// DSCircularImage(
///     .init(
///         imageURL: "https://example.com/avatar.jpg",
///         size: 90,
///         showsBorder: true
///     )
/// )
/// ```
///
/// - Parameter model: The configuration describing URL, size, and border.
/// - Environment:
///   - dsTheme: Design system theme used for colors, spacing, and radii.
///   - colorScheme: The current color scheme (light/dark) used to resolve colors.
public struct DSCircularImage: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    /// The configuration model describing the image URL, size, and border visibility.
    private let model: DSCircularImageModel
    
    /// Creates a circular image view.
    /// - Parameter model: The configuration describing URL, size, and border.
    public init(_ model: DSCircularImageModel) {
        self.model = model
    }
    
    /// The content and layout of the circular image.
    public var body: some View {
        AsyncImage(url: URL(string: model.imageURL)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                // Placeholder de fallback
                ZStack {
                    theme.colors.surfaceSecondary
                        .resolved(scheme)
                    Image(systemName: "person.fill")
                        .foregroundColor(
                            theme.colors.textCaption.resolved(scheme)
                        )
                }
            case .empty:
                ProgressView()
            @unknown default:
                ProgressView()
            }
        }
        .mcGlassEffectIfAvailable()
        .frame(width: model.size, height: model.size)
        .clipShape(Circle())
        .overlay(
            Group {
                if model.showsBorder {
                    Circle()
                        .stroke(
                            theme.colors.primary
                                .resolved(scheme)
                                .opacity(theme.opacity.glassBorder),
                            lineWidth: 2
                        )
                }
            }
        )
    }
}

