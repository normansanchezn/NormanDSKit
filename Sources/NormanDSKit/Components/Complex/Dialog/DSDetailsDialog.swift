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

    public init(model: DSDetailsDialogModel) {
        self.model = model
    }

    public var body: some View {
        DSDialog(
            title: model.title,
            primaryButtonTitle: model.primaryTitle,
            onClose: model.onClose,
            onPrimaryAction: model.onPrimary,
            content: {
                VStack(spacing: theme.spacing.lg) {
                    DSLabel(
                        .init(
                            text: model.dateRange,
                            style: DSLabelModel.Style.accent,
                            isBold: false,
                            textColor: theme.colors.textCaption.resolved(scheme)
                        )
                    )

                    DSLabel(
                        .init(
                            text: model.durationText,
                            style: DSLabelModel.Style.accent,
                            isBold: false,
                            textColor: theme.colors.textCaption.resolved(scheme)
                        )
                    )
                    statusSection
                }
            }
        )
    }
    
    private var statusBinding: Binding<DSStatus> {
        Binding(
            get: { model.status },
            set: { model.onStatusChanged($0) }
        )
    }

    @ViewBuilder
    private var statusSection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            
            DSLabel(
                .init(
                    text: pkgString("tasks.details.status"),
                    style: DSLabelModel.Style.body,
                    isBold: true,
                    textColor: theme.colors.textSubtitle.resolved(scheme)
                )
            )

            Picker(
                selection: statusBinding,
                label: getStatusPickerFieldLabel(text: model.status.displayName)
            ) {
                ForEach(DSStatus.allCases) { status in
                    Text(
                        status.displayName
                    )
                    .tag(status)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    @ViewBuilder
    func getStatusPickerFieldLabel(text : String) -> some View {
        HStack(spacing: theme.spacing.sm) {
            Text(text)
                .font(.callout.weight(.semibold))
                .foregroundStyle(theme.colors.textTitle.resolved(scheme))

            Spacer()

            Image(systemName: "chevron.down")
                .font(.caption.weight(.semibold))
                .foregroundStyle(theme.colors.textCaption.resolved(scheme))
        }
        .padding(.horizontal, theme.spacing.md)
        .padding(.vertical, theme.spacing.sm)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.md)
                .fill(theme.colors.surfaceSecondary.resolved(scheme))
        )
        .overlay(
            RoundedRectangle(cornerRadius: theme.radius.md)
                .stroke(theme.colors.primary.resolved(scheme).opacity(0.6), lineWidth: 1)
        )
    }

}

public extension DSStatus {
    var displayName: String {
        switch self {
        case .completed: return pkgString("tasks.status.completed")
        case .inProcess: return pkgString("tasks.status.in_process")
        case .started:   return pkgString("tasks.status.started")
        case .pending:   return pkgString("tasks.status.pending")
        case .error: return pkgString("task.status.error")
        }
    }
}
