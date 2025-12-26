//
//  DSBackgroundLayer.swift
//  NormanDSKit
//
//  Created by Norman on 26/12/25.
//

import SwiftUI

/// A decorative background layer that fills the screen with a solid color and a grid of non-overlapping doodle icons.
///
/// `DSBackgroundLayer` is intended to be placed behind your content to add subtle visual interest without
/// intercepting user interactions. It renders a full-screen background color and overlays a set of randomly
/// positioned, non-overlapping SF Symbol doodles. The overlay automatically regenerates its layout when the
/// container size changes (e.g., on rotation or size class changes).
///
/// The view disables hit testing so it does not block taps or gestures on content above it.
///
/// Example usage:
/// ```swift
/// ZStack {
///     DSBackgroundLayer(
///         backgroundColor: .black,
///         doodleColor: .white.opacity(0.5),
///         doodleCount: 24
///     )
///
///     // Foreground content goes here
///     ContentView()
/// }
/// ```
///
/// - Note: Doodles are generated using a fixed set of SF Symbols and are placed to avoid overlap
///   using a simple distance-based heuristic. Generation occurs off the main actor to keep the UI responsive.
public struct DSBackgroundLayer: View {
    private let backgroundColor: Color
    private let doodleColor: Color
    private let doodleCount: Int
    private let doodles: [String]?
    
    /// Creates a `DSBackgroundLayer` with the provided colors and number of doodles.
    ///
    /// - Parameters:
    ///   - backgroundColor: The full-screen background color. Defaults to `.black`.
    ///   - doodleColor: The tint color used to render the doodle icons.
    ///   - doodleCount: The total number of doodles to display. Higher values increase visual density
    ///     and may require more time to compute non-overlapping positions.
    public init(
        backgroundColor: Color = .black,
        doodleColor: Color,
        doodleCount: Int,
        doodles: [String]? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.doodleColor = doodleColor
        self.doodleCount = doodleCount
        self.doodles = doodles
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                DSDoodlesOverlay(
                    color: doodleColor,
                    count: doodleCount,
                    doodles: doodles,
                    containerSize: geometry.size
                )
            }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Shared doodles overlay
private struct DSDoodlesOverlay: View {
    @Environment(\.colorScheme) private var scheme
    
    let color: Color
    let count: Int
    let doodles: [String]?
    let containerSize: CGSize
    
    private static let defaultDoodles: [String] = [
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
    
    struct DoodleData: Identifiable {
        let id = UUID()
        let name: String
        let position: CGPoint
        let rotation: Double
        let size: CGFloat
    }
    
    private var doodleOpacity: Double {
        scheme == .dark ? 0.10 : 0.6
    }
    
    private var doodleBlendMode: BlendMode {
        scheme == .dark ? .plusLighter : .normal
    }
    
    var body: some View {
        ZStack {
            ForEach(doodlePositions) { doodle in
                Image(systemName: doodle.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: doodle.size, height: doodle.size)
                    .foregroundStyle(color)
                    .rotationEffect(.degrees(doodle.rotation))
                    .position(doodle.position)
                    .opacity(doodleOpacity)
                    .blendMode(doodleBlendMode)
                    .allowsHitTesting(false)
            }
        }
        .onAppear { regenerateIfNeeded(for: containerSize) }
        .onChange(of: containerSize) { _, newSize in
            regenerateIfNeeded(for: newSize)
        }
    }
    
    private func regenerateIfNeeded(for size: CGSize) {
        guard size.width > 0, size.height > 0 else { return }
        guard size != lastSize else { return }
        lastSize = size
        
        Task.detached(priority: .utility) {
            let positions = await generateDoodles(in: size)
            await MainActor.run { doodlePositions = positions }
        }
    }
    
    private func generateDoodles(in size: CGSize) -> [DoodleData] {
        let symbols = (doodles?.isEmpty == false) ? doodles! : Self.defaultDoodles
        
        var placed: [DoodleData] = []
        
        let doodleSize: CGFloat = 45
        let minDistance = doodleSize * 0.8
        let maxAttempts = 25
        
        let xMin = doodleSize / 2
        let yMin = doodleSize / 2
        let xMax = max(xMin, size.width - xMin)
        let yMax = max(yMin, size.height - yMin)
        
        for _ in 0..<count {
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
                    name: symbols.randomElement() ?? "star.fill",
                    position: chosen,
                    rotation: Double.random(in: 0...360),
                    size: doodleSize
                )
            )
        }
        
        return placed
    }
}

