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

    struct DoodleData: Identifiable {
        let id = UUID()
        let name: String
        let position: CGPoint
        let rotation: Double
        let size: CGFloat
    }
    
    public init(
        doodleColor: Color,
        doodleCount: Int
    ) {
        self.doodleColor = doodleColor
        self.doodleCount = doodleCount
    }

    public var body: some View {
        // Usamos un GeometryProxy que ignore el safe area
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                ForEach(doodlePositions) { doodle in
                    Image(systemName: doodle.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: doodle.size, height: doodle.size)
                        .foregroundColor(doodleColor)
                        .rotationEffect(.degrees(doodle.rotation))
                        .position(doodle.position)
                        .opacity(0.5)
                }
            }
            .onAppear {
                generateNonOverlappingDoodles(in: geometry.frame(in: .global).size)
            }
        }
        .ignoresSafeArea() // Esto hace que el componente use los pixeles de borde a borde
    }

    private func generateNonOverlappingDoodles(in size: CGSize) {
        var placedDoodles: [DoodleData] = []
        let doodleSize: CGFloat = 45
        let minDistance = doodleSize * 1.2 // Espacio mínimo entre centros
        
        // Intentamos colocar la cantidad deseada, pero con un límite de intentos para evitar bucles infinitos
        for _ in 0..<doodleCount {
            var attempts = 0
            var placed = false
            
            while !placed && attempts < 50 {
                let randomX = CGFloat.random(in: 0...size.width)
                let randomY = CGFloat.random(in: 0...size.height)
                let newPos = CGPoint(x: randomX, y: randomY)
                
                // Verificar si choca con alguno ya colocado
                let collision = placedDoodles.contains { existing in
                    let distance = sqrt(pow(existing.position.x - newPos.x, 2) + pow(existing.position.y - newPos.y, 2))
                    return distance < minDistance
                }
                
                if !collision {
                    let newDoodle = DoodleData(
                        name: doodles.randomElement() ?? "star.fill",
                        position: newPos,
                        rotation: Double.random(in: 0...360),
                        size: doodleSize
                    )
                    placedDoodles.append(newDoodle)
                    placed = true
                }
                attempts += 1
            }
        }
        doodlePositions = placedDoodles
    }
}


#Preview {
    @Previewable @Environment(\.dsTheme)  var theme
    @Previewable @Environment(\.colorScheme)  var scheme
    DSBackground(
        doodleColor: Color(hex: "#00C2FF"), doodleCount: 500
    )
}
