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
    
    @State private var didTimeout = false
    
    private let timeoutNanoseconds: UInt64 = 6_000_000_000
    
    /// Creates a circular image view.
    /// - Parameter model: The configuration describing URL, size, and border.
    public init(_ model: DSCircularImageModel) {
        self.model = model
    }
    
    /// The content and layout of the circular image.
    public var body: some View {
        Group {
            if let url = resolvedURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        
                    case .failure:
                        placeholder
                        
                    case .empty:
                        if didTimeout {
                            placeholder
                        } else {
                            loading
                        }
                        
                    @unknown default:
                        placeholder
                    }
                }
                .task(id: resolvedURL?.absoluteString) {
                    didTimeout = false
                    do {
                        try await Task.sleep(nanoseconds: timeoutNanoseconds)
                        didTimeout = true
                    } catch {
                        print("We have some issues.")
                    }
                }
            } else {
                placeholder
            }
        }
        .mcGlassEffectIfAvailable()
        .frame(width: model.size, height: model.size)
        .clipShape(Circle())
        .overlay(borderOverlay)
    }
    
    private var resolvedURL: URL? {
            let raw = model.imageURL.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !raw.isEmpty else { return nil }

            if let url = URL(string: raw) { return url }

            let escaped = raw.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            if let escaped, let url = URL(string: escaped) { return url }

            return nil
        }

        private var loading: some View {
            ZStack {
                theme.colors.surfaceSecondary.resolved(scheme)
                ProgressView()
                    .tint(theme.colors.textCaption.resolved(scheme))
            }
        }

        private var placeholder: some View {
            DSEmojiImageView(imgResName: "error_emoji", size: 30, scale: 1)
        }

        private var borderOverlay: some View {
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
        }
}

