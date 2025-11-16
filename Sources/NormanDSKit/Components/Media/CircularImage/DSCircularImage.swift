//
//  DSCircularImage.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

public struct DSCircularImage: View {
    
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let model: DSCircularImageModel
    
    public init(_ model: DSCircularImageModel) {
        self.model = model
    }
    
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
