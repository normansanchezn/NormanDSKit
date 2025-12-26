//
//  DSBackground.swift
//  NormanDSKit
//
//  Created by Norman on 22/12/25.
//

import SwiftUI

/// A decorative, theme-friendly background that renders random SF Symbols behind your content.
///
/// `DSBackground` paints a solid color and lays out a set of randomly distributed
/// SF Symbols ("doodles") while avoiding basic collisions. Your provided `content`
/// is rendered on top.
///
/// - SeeAlso: ``DSBackgroundLayer`` for a lightweight, layer-only variant intended
///   to be placed behind other views or used with container backgrounds.
public struct DSBackground<Content: View>: View {
    @Environment(\.colorScheme) private var scheme
    private var doodleOpacity: Double {
        scheme == .dark ? 0.10 : 0.6
    }
    private var doodleBlendMode: BlendMode {
        scheme == .dark ? .plusLighter : .normal
    }
    private let backgroundColor: Color
    private let doodleColor: Color
    private let doodleCount: Int
    private let doodlesOverride: [String]?
    private let content: () -> Content

    /// The default set of SF Symbols used when no custom doodles are provided.
    private let defaultDoodles: [String] = [
        "book.fill",
        "person.2.fill",
        "lightbulb.fill",
        "graduationcap.fill",
        "star.fill",
        "brain.head.profile",
        "bubble.left.and.bubble.right.fill",
        "hand.raised.fill"
    ]

    @State private var doodlePositions: [DoodleData] = []
    @State private var lastSize: CGSize = .zero

    /// Internal model for a placed doodle.
    private struct DoodleData: Identifiable {
        let id = UUID()
        let name: String
        let position: CGPoint
        let rotation: Double
        let size: CGFloat
    }

    /// Creates a decorative background with randomly positioned SF Symbols behind your content.
    ///
    /// - Parameters:
    ///   - backgroundColor: The solid background color to paint underneath the doodles. Defaults to `.black`.
    ///   - doodleColor: The color used for all the SF Symbol doodles.
    ///   - doodleCount: The number of doodles to generate and layout randomly.
    ///   - doodles: An optional array of SF Symbol names to use instead of the default set.
    ///   - content: A closure returning the content view to be rendered on top of the doodles.
    public init(
        backgroundColor: Color = .black,
        doodleColor: Color,
        doodleCount: Int,
        doodles: [String]? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.doodleColor = doodleColor
        self.doodleCount = doodleCount
        self.doodlesOverride = doodles
        self.content = content
    }

    /// The composed background and foreground content.
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor.ignoresSafeArea()

                ForEach(doodlePositions) { doodle in
                    Image(systemName: doodle.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: doodle.size, height: doodle.size)
                        .foregroundStyle(doodleColor)
                        .rotationEffect(.degrees(doodle.rotation))
                        .position(doodle.position)
                        .opacity(doodleOpacity)
                        .blendMode(doodleBlendMode)
                        .allowsHitTesting(false)
                }

                content()
            }
            .task(id: geometry.size) {
                await regenerateIfNeeded(in: geometry.size)
            }
        }
    }

    /// Regenerates doodles when the container size changes.
    /// - Parameter size: The available container size used for layout.
    @MainActor
    private func regenerateIfNeeded(in size: CGSize) async {
        guard size.width > 0, size.height > 0 else { return }
        guard size != lastSize else { return }
        lastSize = size
        doodlePositions = generateDoodles(in: size)
    }

    /// Generates non-overlapping doodles within the given container size.
    /// - Parameter size: The size in which to layout doodles.
    /// - Returns: A list of placed doodles including symbol, position, rotation, and size.
    private func generateDoodles(in size: CGSize) -> [DoodleData] {
        let source = (doodlesOverride?.isEmpty == false) ? doodlesOverride! : self.defaultDoodles

        var placed: [DoodleData] = []

        let doodleSize: CGFloat = 45
        let minDistance = doodleSize * 0.8
        let maxAttempts = 25

        let xMin = doodleSize / 2
        let yMin = doodleSize / 2
        let xMax = max(xMin, size.width - xMin)
        let yMax = max(yMin, size.height - yMin)

        for _ in 0..<doodleCount {
            var attempts = 0
            var chosen = CGPoint(
                x: CGFloat.random(in: xMin...xMax),
                y: CGFloat.random(in: yMin...yMax)
            )

            while attempts < maxAttempts {
                let candidate = CGPoint(
                    x: CGFloat.random(in: xMin...xMax),
                    y: CGFloat.random(in: yMin...yMax)
                )

                let collision = placed.contains { existing in
                    let dx = existing.position.x - candidate.x
                    let dy = existing.position.y - candidate.y
                    return sqrt(dx*dx + dy*dy) < minDistance
                }

                if !collision {
                    chosen = candidate
                    break
                }

                attempts += 1
            }

            placed.append(
                DoodleData(
                    name: source.randomElement() ?? "star.fill",
                    position: chosen,
                    rotation: Double.random(in: 0...360),
                    size: doodleSize
                )
            )
        }

        return placed
    }
}


#Preview {
    @Previewable @Environment(\.dsTheme)  var theme
    @Previewable @Environment(\.colorScheme)  var scheme
    DSBackground(
        doodleColor: Color(hex: "#00C2FF"), doodleCount: 30
    ) {
        EmptyView()
    }
}

