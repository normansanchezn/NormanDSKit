//
//  DSBackgroundLayer.swift
//  NormanDSKit
//
//  Created by Norman on 26/12/25.
//

import SwiftUI

public struct DSBackgroundLayer: View {
    private let backgroundColor: Color
    private let doodleColor: Color
    private let doodleCount: Int

    public init(
        backgroundColor: Color = .black,
        doodleColor: Color,
        doodleCount: Int
    ) {
        self.backgroundColor = backgroundColor
        self.doodleColor = doodleColor
        self.doodleCount = doodleCount
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor.ignoresSafeArea()

                DSDoodlesOverlay(
                    color: doodleColor,
                    count: doodleCount,
                    containerSize: geometry.size
                )
            }
        }
        .allowsHitTesting(false) // importante para que no bloquee taps
    }
}

// MARK: - Shared doodles overlay (extraído de tu DSBackground)
private struct DSDoodlesOverlay: View {
    let color: Color
    let count: Int
    let containerSize: CGSize

    private let doodles = [
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

    var body: some View {
        ZStack {
            ForEach(doodlePositions) { doodle in
                Image(systemName: doodle.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: doodle.size, height: doodle.size)
                    .foregroundColor(color)
                    .rotationEffect(.degrees(doodle.rotation))
                    .position(doodle.position)
                    .opacity(0.5)
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

        // Genera off-main para no trabar UI si count es alto
        Task.detached(priority: .utility) {
            let positions = await generateNonOverlappingDoodles(in: size)
            await MainActor.run {
                doodlePositions = positions
            }
        }
    }

    private func generateNonOverlappingDoodles(in size: CGSize) -> [DoodleData] {
        var placed: [DoodleData] = []
        let doodleSize: CGFloat = 45
        let minDistance = doodleSize * 1.2

        for _ in 0..<count {
            var attempts = 0
            var didPlace = false

            while !didPlace && attempts < 50 {
                let x = CGFloat.random(in: 0...size.width)
                let y = CGFloat.random(in: 0...size.height)
                let newPos = CGPoint(x: x, y: y)

                let collision = placed.contains { existing in
                    let dx = existing.position.x - newPos.x
                    let dy = existing.position.y - newPos.y
                    return sqrt(dx*dx + dy*dy) < minDistance
                }

                if !collision {
                    placed.append(
                        DoodleData(
                            name: doodles.randomElement() ?? "star.fill",
                            position: newPos,
                            rotation: Double.random(in: 0...360),
                            size: doodleSize
                        )
                    )
                    didPlace = true
                }

                attempts += 1
            }
        }

        return placed
    }
}
