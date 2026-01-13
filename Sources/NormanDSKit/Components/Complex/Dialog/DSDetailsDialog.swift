//
//  DSDetailsDialog.swift
//  NormanDSKit
//
//  Created by Norman on 27/12/25.
//

import SwiftUI

public struct DSDetailsDialog: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme

    private let model: DSDetailsDialogModel

    private var contentShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous)
    }

    private var fieldShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous)
    }

    public init(model: DSDetailsDialogModel) {
        self.model = model
    }

    public var body: some View {
        DSDialog(
            subtitle: nil,
            primaryButtonTitle: model.primaryTitle,
            closeButtonTitle: pkgString("common.close"),
            onClose: model.onClose,
            onPrimaryAction: model.onPrimary,
            emojiType: .info
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.md) {
                taskTitleSection

                HStack(spacing: theme.spacing.sm) {
                    infoPill(
                        title: pkgString("task_dialog.task.due_date"),
                        value: model.dateRange,
                        systemImage: "calendar"
                    )
                    infoPill(
                        title: pkgString("task_dialog.task.duration_time"),
                        value: model.durationText,
                        systemImage: "clock"
                    )
                }
                .fixedSize(horizontal: false, vertical: true)

                statusSection
            }
            .padding(theme.spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .mcGlassBackground(
                in: contentShape,
                tint: theme.colors.boxBackground.resolved(scheme),
                tintOpacity: theme.opacity.boxBackground
            )
            .overlay {
                contentShape.stroke(
                    theme.colors.onBackground.resolved(scheme).opacity(theme.opacity.subtle),
                    lineWidth: 1
                )
            }
            .padding(.top, theme.spacing.xs)
        }
    }

    private var taskTitleSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            DSLabel(.init(
                text: pkgString("task_dialog.task.name.details"),
                style: .caption,
                textColor: theme.colors.textCaption.resolved(scheme)
            ))

            DSLabel(.init(
                text: model.title,
                style: .subtitle,
                isBold: true,
                textColor: theme.colors.textTitle.resolved(scheme)
            ))
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.spacing.md)
        .mcGlassBackground(
            in: contentShape,
            tint: theme.colors.boxBackground.resolved(scheme),
            tintOpacity: theme.opacity.boxBackground
        )
        .overlay(cardBorder)
        .clipShape(cardShape)
    }

    private func infoPill(title: String, value: String, systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(theme.colors.textCaption.resolved(scheme))

                DSLabel(.init(
                    text: title,
                    style: .caption,
                    textColor: theme.colors.textCaption.resolved(scheme)
                ))

                Spacer(minLength: 0)
            }

            DSLabel(.init(
                text: value,
                style: .accent,
                textColor: theme.colors.textBody.resolved(scheme)
            ))
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(theme.spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .mcGlassBackground(
            in: contentShape,
            tint: theme.colors.boxBackground.resolved(scheme),
            tintOpacity: theme.opacity.boxBackground
        )
        .overlay(cardBorder)
        .clipShape(cardShape)
    }

    private var statusSection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            DSLabel(.init(
                text: pkgString("tasks.details.status"),
                style: .caption,
                isBold: true,
                textColor: theme.colors.textCaption.resolved(scheme)
            ))

            Menu {
                ForEach(DSStatus.allCases) { status in
                    Button {
                        model.onStatusChanged(status)
                    } label: {
                        Label(status.displayName, systemImage: statusIcon(status))
                    }
                }
            } label: {
                statusFieldLabel
            }
            .buttonStyle(.plain)
            .mcGlassBackground(
                in: contentShape,
                tint: theme.colors.boxBackground.resolved(scheme),
                tintOpacity: theme.opacity.boxBackground
            )
        }
    }

    private var statusFieldLabel: some View {
        HStack(spacing: theme.spacing.sm) {
            DSStatusPill(text: model.status.displayName, status: model.status)

            Spacer()

            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(theme.colors.textCaption.resolved(scheme))
        }
        .padding(.horizontal, theme.spacing.md)
        .padding(.vertical, 12)
        .mcGlassBackground(
            in: contentShape,
            tint: theme.colors.boxBackground.resolved(scheme),
            tintOpacity: theme.opacity.boxBackground
        )
        .overlay(fieldBorder)
        .clipShape(fieldShape)
        .contentShape(Rectangle())
    }

    // MARK: - Backgrounds
    private var cardBackground: some View {
        theme.colors.surfaceSecondary
            .resolved(scheme)
            .opacity(theme.opacity.glassBackground)
            .background(.ultraThinMaterial)
    }

    private var cardBorder: some View {
        cardShape.stroke(
            theme.colors.onBackground.resolved(scheme).opacity(theme.opacity.subtle),
            lineWidth: 1
        )
    }

    private var fieldBackground: some View {
        theme.colors.surfaceSecondary
            .resolved(scheme)
            .opacity(theme.opacity.glassBackground)
            .background(.ultraThinMaterial)
    }

    private var fieldBorder: some View {
        fieldShape.stroke(
            theme.colors.primary.resolved(scheme).opacity(0.35),
            lineWidth: 1
        )
    }

    private func statusIcon(_ status: DSStatus) -> String {
        switch status {
        case .pending:   return "hourglass"
        case .started:   return "play.fill"
        case .inProcess: return "arrow.triangle.2.circlepath"
        case .completed: return "checkmark.seal.fill"
        case .error:     return "exclamationmark.triangle.fill"
        }
    }
}

public extension DSStatus {
    var displayName: String {
        switch self {
        case .completed: return pkgString("tasks.status.completed")
        case .inProcess: return pkgString("tasks.status.in_process")
        case .started:   return pkgString("tasks.status.started")
        case .pending:   return pkgString("tasks.status.pending")
        case .error:     return pkgString("task.status.error")
        }
    }
}

