//
//  DSRemoteAvatar.swift
//  NormanDSKit
//
//  Created by Norman on 29/12/25.
//

import SwiftUI

public struct DSRemoteAvatar: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let urlString: String?
    private let size: CGFloat

    public init(urlString: String?, size: CGFloat) {
        self.urlString = urlString
        self.size = size
    }

    public var body: some View {
        Group {
            if let urlString, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(
            Circle().stroke(theme.colors.onBackground.resolved(scheme).opacity(theme.opacity.subtle), lineWidth: 1)
        )
        .accessibilityLabel("Avatar")
    }

    private var placeholder: some View {
        ZStack {
            theme.colors.surfaceSecondary.resolved(scheme)
            DSEmojiImageView(imgResName: "greeting_emoji", size: size - 3)
        }
    }
}
