/// DSProgressView
///
/// A customizable animated progress indicator that cycles through SF Symbols.
///
/// `DSProgressView` displays a rotating ring using the Design System's primary color
/// and shows a sequence of SF Symbols in the center that change dynamically in both
/// symbol and color. Use it to indicate loading or indeterminate progress states.
///
/// - Features:
///   - Animated circular progress ring with continuous rotation.
///   - Center icon that cycles through a configurable list of SF Symbols.
///   - Themed colors that adapt to the environment's color scheme.
///   - Optional label below the indicator.
///   - Configurable size.
///
/// - Important: `DSProgressView` relies on the `dsTheme` environment key to resolve
///   colors for the current color scheme. Ensure your view hierarchy injects a theme.
///
/// - SeeAlso: ``DSBackground``

//
//  DSProgressView.swift
//  NormanDSKit
//
//  Created by Norman on 01/01/26.
//

import SwiftUI

/// A customizable animated loading indicator that cycles through SF Symbols.
///
/// `DSProgressView` shows a spinning ring using the Design System's primary color and presents
/// a sequence of icons in the center that change dynamically over time. The component adapts
/// to light/dark mode and theme colors provided via the environment. You can optionally
/// provide a descriptive label and configure the overall size.
public struct DSProgressView: View {
    @Environment(\.colorScheme) private var scheme
    @Environment(\.dsTheme) private var theme
    
    // MARK: - Configuración
    private let icons: [String]
    private let label: String?
    private let size: CGFloat
    private let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
    // MARK: - Estado
    @State private var currentIndex: Int = 0
    @State private var isAnimating: Bool = false
    
    /// Default icons.
    private let defaultIcons: [String] = [
        "star.fill",
        "brain.head.profile",
        "lightbulb.fill",
        "person.2.fill",
        "sparkles"
    ]
    
    /// Creates a new progress view.
    ///
    /// - Parameters:
    ///   - icons: An optional array of SF Symbol names to cycle through. If `nil` or empty,
    ///     a default set of icons is used. Icons are displayed in the center of the ring.
    ///   - label: An optional text displayed below the indicator to describe the loading action.
    ///   - size: The outer diameter of the circular indicator, in points.
    ///
    /// - Note: Colors are resolved from the Design System theme for the current color scheme.
    /// - SeeAlso: ``DSBackground``
    public init(
        icons: [String]? = nil,
        label: String? = nil,
        size: CGFloat = 60
    ) {
        self.icons = (icons?.isEmpty == false) ? icons! : defaultIcons
        self.label = label
        self.size = size
    }
    
    // MARK: - Computed Logic
    /// Calculates the icon color based on the current index.
    /// Sequence: Primary -> Secondary -> Tertiary -> (Repeat)
    private var currentIconColor: Color {
        let cycleIndex = currentIndex % 2
        switch cycleIndex {
        case 0:
            return theme.colors.primary.resolved(scheme)
        case 1:
            return theme.colors.tertiary.resolved(scheme)
        default:
            return theme.colors.primary.resolved(scheme)
        }
    }
    
    /// The content and behavior of the progress view.
    public var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(
                        theme.colors.surfaceSecondary.resolved(scheme),
                        lineWidth: 6
                    )
                    .frame(width: size, height: size)
                
                Circle()
                    .trim(from: 0, to: 0.25)
                    .stroke(
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .foregroundStyle(theme.colors.primary.resolved(scheme))
                    .frame(width: size, height: size)
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .animation(
                        Animation.linear(duration: 1.5).repeatForever(autoreverses: false),
                        value: isAnimating
                    )
                
                if let currentIcon = icons[safe: currentIndex] {
                    Image(systemName: currentIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size * 0.4, height: size * 0.4)
                        .foregroundStyle(currentIconColor)
                        .symbolReplaceTransitionIfAvailable()
                        .id(currentIndex)
                }
            }
            
            if let label = label {
                Text(label)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(theme.colors.textSubtitle.resolved(scheme))
            }
        }
        .onAppear {
            isAnimating = true
        }
        .onReceive(timer) { _ in
            withAnimation(.snappy) {
                currentIndex = (currentIndex + 1) % icons.count
            }
        }
    }
}

// MARK: - Helpers
private extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK: - Preview
/// ## Example
///
/// The following example shows `DSProgressView` with custom icons, label, and size:
///
/// ```swift
/// DSProgressView(
///     icons: ["star.fill", "heart.fill", "bolt.fill", "leaf.fill", "drop.fill"],
///     label: "Loading resources...",
///     size: 80
/// )
/// ```
#Preview {
    ZStack {
        DSBackground(
            doodleColor: .gray.opacity(0.3),
            doodleCount: 15
        ) {
            VStack(spacing: 50) {
                DSProgressView(
                    icons: ["star.fill", "heart.fill", "bolt.fill", "leaf.fill", "drop.fill"],
                    label: "Cargando recursos...",
                    size: 80
                )
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
            }
        }
    }
}
