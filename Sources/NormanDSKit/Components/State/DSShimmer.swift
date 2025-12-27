//
//  DSShimmer.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import SwiftUI

private struct DSShimmer: ViewModifier {
    @State private var phase: CGFloat = -1
    let active: Bool

    func body(content: Content) -> some View {
        content
            .overlay {
                if active {
                    GeometryReader { geo in
                        LinearGradient(
                            colors: [
                                .clear,
                                Color.white.opacity(0.25),
                                .clear
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .rotationEffect(.degrees(18))
                        .offset(x: phase * geo.size.width * 2)
                        .blendMode(.plusLighter)
                        .onAppear {
                            withAnimation(.linear(duration: 1.15).repeatForever(autoreverses: false)) {
                                phase = 1
                            }
                        }
                    }
                    .clipped()
                }
            }
    }
}

public extension View {
    func dsShimmer(_ active: Bool = true) -> some View {
        modifier(DSShimmer(active: active))
    }
}
