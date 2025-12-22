//
//  DSBackground.swift
//  NormanDSKit
//
//  Created by Norman on 22/12/25.
//

import SwiftUI

public struct DSBackground: View {
    let doodleColor: Color
    let doodleCount: Int
    
    private let doodles = ["book.fill", "person.2.fill", "lightbulb.fill", "graduationcap.fill", "star.fill", "brain.head.profile", "bubble.left.and.bubble.right.fill", "hand.raised.fill"]
    
    @State private var doodlePositions: [DoodleData] = []
    
    public init(
        doodleColor: Color = .white,
        doodleCount: Int = 300
    ) {
        self.doodleColor = doodleColor
        self.doodleCount = doodleCount
    }

    struct DoodleData: Identifiable {
        let id = UUID()
        let name: String
        let position: CGPoint
        let rotation: Double
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                ForEach(doodlePositions) { doodle in
                    Image(systemName: doodle.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(doodleColor)
                        .rotationEffect(.degrees(doodle.rotation))
                        .position(doodle.position)
                        .opacity(0.6)
                }
            }
            .onAppear {
                generateDoodles(in: geometry.size)
            }
        }
    }

    private func generateDoodles(in size: CGSize) {
        var newPositions: [DoodleData] = []
        let padding: CGFloat = 30
        
        for _ in 0..<doodleCount {
            let randomX = CGFloat.random(in: padding...(size.width - padding))
            let randomY = CGFloat.random(in: padding...(size.height - padding))
            let randomRotation = Double.random(in: 0...360)
            let randomIcon = doodles.randomElement() ?? "star.fill"
            
            newPositions.append(DoodleData(
                name: randomIcon,
                position: CGPoint(x: randomX, y: randomY),
                rotation: randomRotation
            ))
        }
        doodlePositions = newPositions
    }
}


#Preview {
    @Previewable @Environment(\.dsTheme)  var theme
    @Previewable @Environment(\.colorScheme)  var scheme
    DSBackground(
        doodleColor: Color(hex: "#00C2FF"), doodleCount: 500
    )
}
