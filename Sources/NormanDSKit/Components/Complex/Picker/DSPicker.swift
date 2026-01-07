//
//  DSPicker.swift
//  NormanDSKit
//
//  Created by Norman on 01/01/26.
//

import SwiftUI

public struct DSPicker<Option: Identifiable & Equatable>: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    private let placeholder: String
    private let options: [Option]
    
    private let display: (Option) -> String
    private let detail: (Option) -> String?
    private let icon: (Option) -> String?
    
    @Binding private var selection: Option?
    @State private var isSheetPresented = false
    
    public init(
        placeholder: String,
        options: [Option],
        selection: Binding<Option?>,
        display: @escaping (Option) -> String,
        detail: @escaping (Option) -> String? = { _ in nil },
        icon: @escaping (Option) -> String? = { _ in nil }
    ) {
        self.placeholder = placeholder
        self.options = options
        self._selection = selection
        self.display = display
        self.detail = detail
        self.icon = icon
    }
    
    public init(
        title: String,
        subtitle: String? = nil,
        options: [Option],
        selection: Binding<Option>,
        display: @escaping (Option) -> String,
        detail: @escaping (Option) -> String? = { _ in nil },
        icon: @escaping (Option) -> String? = { _ in nil }
    ) {
        self.placeholder = display(selection.wrappedValue)
        self.options = options
        self._selection = Binding<Option?>(
            get: { selection.wrappedValue },
            set: { if let v = $0 { selection.wrappedValue = v } }
        )
        self.display = display
        self.detail = detail
        self.icon = icon
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Button { isSheetPresented = true } label: {
                HStack(spacing: theme.spacing.md) {
                    if let sel = selection, let iconName = icon(sel) {
                        Image(systemName: iconName)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(theme.colors.primary.resolved(scheme))
                    } else {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(theme.colors.textCaption.resolved(scheme))
                    }
                    
                    Text(resolveText())
                        .font(.system(.body, design: .rounded).weight(.semibold))
                        .foregroundStyle(theme.colors.textBody.resolved(scheme))
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(theme.colors.textCaption.resolved(scheme))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)
        }
        .sheet(isPresented: $isSheetPresented) { sheet }
        .animation(.spring(response: 0.35, dampingFraction: 0.9), value: selection?.id)
    }
    
    private func resolveText() -> String {
        let selection = self.selection.map(display)
        
        return selection?.capitalizingFirstLetter() ?? placeholder
    }
    
    private func resolveOptionText(opt: Option) -> String {
        display(opt).capitalizingFirstLetter()
    }
    
    private var sheet: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack { sheetContent }
            } else {
                NavigationView { sheetContent }
                    .navigationViewStyle(.stack)
            }
        }
        .mcPresentationIfAvailable(detents: [.medium, .large], dragIndicatorVisible: true)
    }
    
    private var sheetContent: some View {
        ZStack {
            theme.colors.dialogBackgroundColor.resolved(scheme)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: theme.spacing.sm) {
                    ForEach(options) { opt in
                        row(opt)
                    }
                }
                .padding(.horizontal, theme.spacing.lg)
                .padding(.top, theme.spacing.md)
                .padding(.bottom, theme.spacing.xl)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { isSheetPresented = false } label: {
                    Image(systemName: "xmark")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(theme.colors.textCaption.resolved(scheme))
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .presentationBackgroundIfAvailable(theme.colors.background.resolved(scheme))
    }
    
    private func row(_ opt: Option) -> some View {
        let isSelected = (selection == opt)
        
        return Button {
            selection = opt
            isSheetPresented = false
        } label: {
            HStack(spacing: theme.spacing.md) {
                if let iconName = icon(opt) {
                    Image(systemName: iconName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(isSelected
                                         ? theme.colors.primary.resolved(scheme)
                                         : theme.colors.textCaption.resolved(scheme))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(resolveOptionText(opt: opt))
                        .font(.system(.body, design: .rounded).weight(.semibold))
                        .foregroundStyle(theme.colors.textBody.resolved(scheme))
                    
                    if let d = detail(opt), !d.isEmpty {
                        Text(d)
                            .font(.caption)
                            .foregroundStyle(theme.colors.textCaption.resolved(scheme))
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(isSelected ? .green : theme.colors.textCaption.resolved(scheme))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                    .fill(theme.colors.surface.resolved(scheme).opacity(theme.opacity.glassBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.radius.lg, style: .continuous)
                    .stroke(
                        isSelected
                        ? theme.colors.primary.resolved(scheme).opacity(0.55)
                        : theme.colors.onBackground.resolved(scheme).opacity(theme.opacity.subtle),
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
