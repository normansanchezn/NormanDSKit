//
//  DSHeaderModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 16/11/25.
//

import SwiftUI

/// A configuration model describing the content and behavior of a `DSHeader`.
///
/// Use `DSHeaderModel` to specify the header's title, optional subtitle, optional
/// system image, style (large or standard), and the visibility of back/close buttons.
///
/// ### Example
/// ```swift
/// let model = DSHeaderModel(
///     title: "Dashboard",
///     subtitle: "Overview",
///     systemImage: "chart.bar",
///     style: .large,
///     showsBackButton: false,
///     showsCloseButton: false
/// )
/// ```
public struct DSHeaderModel {
    
    /// Header presentation styles.
    public enum Style {
        /// Large title style (root/home sections).
        case large
        /// Standard toolbar style (detail flows).
        case standard
    }
    
    /// The main header title.
    public let title: String
    /// An optional subtitle shown below the title.
    public let subtitle: String?
    /// An optional SF Symbol shown next to the title.
    public let systemImage: String?
    /// The header style (large or standard).
    public let style: Style
    /// Whether to show a back button on the leading side.
    public let showsBackButton: Bool
    /// Whether to show a close button on the leading side.
    public let showsCloseButton: Bool
    
    /// Creates a header model.
    /// - Parameters:
    ///   - title: The main header title.
    ///   - subtitle: An optional subtitle shown below the title.
    ///   - systemImage: An optional SF Symbol shown next to the title.
    ///   - style: The header style. Defaults to `.large`.
    ///   - showsBackButton: Whether to show a back button. Defaults to `false`.
    ///   - showsCloseButton: Whether to show a close button. Defaults to `false`.
    public init(
        title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        style: Style = .large,
        showsBackButton: Bool = false,
        showsCloseButton: Bool = false
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.style = style
        self.showsBackButton = showsBackButton
        self.showsCloseButton = showsCloseButton
    }
}
