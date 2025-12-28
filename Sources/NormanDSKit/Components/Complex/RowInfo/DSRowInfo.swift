//
//  RowInfo.swift
//  MentorConnect
//
//  Created by Norman Sanchez on 19/11/25.
//

import SwiftUI

/// A card-style row showing a date range, title, duration, and participants.
///
/// `DSRowInfo` renders a styled container with a header (date range), a bold title,
/// a small duration chip, and up to three participant avatars plus an optional
/// extra count. Swipe actions allow deletion when `onDelete` is provided.
///
/// ### Example
/// ```swift
/// DSRowInfo(.init(
///     dateRange: "25/11/19 - 25/11/29",
///     title: "Task name example",
///     durationText: "Two weeks",
///     avatarURLs: ["https://example.com/a.jpg"],
///     extraCount: 3,
///     onDelete: { print("Deleted") }
/// ))
/// ```
///
/// - Parameters:
///   - rowInfoModel: The model containing date range, title, duration, avatars, extra count, and callbacks.
///
/// - Environment:
///   - dsTheme: Design system theme used for colors, spacing, and radii.
///   - colorScheme: The current color scheme (light/dark) used to resolve colors.
public struct DSRowInfo: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    // MARK: - Props
    public let dateRange: String
    public let title: String
    public let durationText: String
    public let avatarURLs: [String]
    public let extraCount: Int
    public let statusText: String?
    
    // Callbacks
    public var onDelete: (() -> Void)?
    
    // MARK: - Init
    public init(
        _ rowInfoModel: DSRowInfoModel
    ) {
        self.dateRange = rowInfoModel.dateRange
        self.title = rowInfoModel.title
        self.durationText = rowInfoModel.durationText
        self.avatarURLs = rowInfoModel.avatarURLs
        self.extraCount = rowInfoModel.extraCount
        self.statusText = rowInfoModel.statusText
        self.onDelete = rowInfoModel.onDelete
    }
    
    // MARK: - Body
    public var body: some View {
        content
            .contentShape(Rectangle())
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    onDelete?()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .contentShape(Rectangle())
                .padding(.vertical, 2)
            }
    }
    
    // MARK: - Content
    private var content: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            HStack {
                DSLabel(
                    .init(
                        text: dateRange,
                        style: .caption,
                        isBold: false,
                        textColor: .white
                    )
                )
                .foregroundStyle(
                    theme.colors.textCaption.resolved(scheme)
                )
            }
            
            DSLabel(
                .init(
                    text: title,
                    style: .h2,
                    isBold: true,
                    textColor: .white
                )
            )
            .foregroundStyle(
                theme.colors.textTitle.resolved(scheme)
            )
            
            HStack {
                Text(durationText)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(theme.colors.decorativeDoodle.resolved(scheme))
                    )
                    .overlay(
                        Capsule()
                            .stroke(
                                theme.colors.surfaceSecondary
                                    .resolved(scheme)
                                    .opacity(0.35),
                                lineWidth: 1
                            )
                    )
                    .accessibilityLabel(Text("Duration \(durationText)"))
                
                Spacer()
                
                HStack(spacing: -12) {
                    ForEach(Array(avatarURLs.prefix(3)).indices, id: \.self) { index in
                        DSCircularImage(
                            .init(
                                imageURL: avatarURLs[index],
                                size: 28,
                                showsBorder: true
                            )
                        )
                        .zIndex(Double(3 - index))
                    }
                    
                    if extraCount > 0 {
                        Text("+\(extraCount)")
                            .font(.caption2.weight(.semibold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(
                                Circle()
                                    .fill(
                                        theme.colors.textSubtitle
                                            .resolved(scheme)
                                            .opacity(0.6)
                                    )
                            )
                            .overlay(
                                Circle()
                                    .stroke(
                                        theme.colors.primary
                                            .resolved(scheme)
                                            .opacity(theme.opacity.glassBorder),
                                        lineWidth: 1
                                    )
                            )
                            .padding(.leading, 6)
                            .accessibilityHidden(true)
                    }
                }
            }
        }
        .padding(.horizontal, theme.spacing.lg)
        .padding(.vertical, theme.spacing.md)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.lg)
                .fill(
                    theme.colors.primary.resolved(scheme)
                        .opacity(theme.opacity.glassBackground)
                )
        )
        .overlay(alignment: .topTrailing) {
            if let statusText, !statusText.isEmpty {
                DSStatusPill(
                    text: statusText,
                    status: .init(from: statusText)
                )
                .padding(.top, 10)
                .padding(.trailing, 10)
            }
        }
    }
}
