///
/// DSUserCard
///
/// A lightweight profile card that displays a rounded image, a decorative rotated background, and two text labels for name and job description. The card is tappable and triggers the provided action.
///
/// Use `DSUserCard` with a `DSUserCardModel` to configure content, colors, and sizing. The view respects the design system theme via the `dsTheme` environment key.
///
/// ### Example
/// ```swift
/// DSUserCard(
///     personalCardModel: .init(
///         imageURL: "https://example.com/avatar.jpg",
///         name: "Alex Doe",
///         jobDescription: "iOS Engineer",
///         actionCallback: { print("Tapped") },
///         colorBackground: .blue,
///         widthSize: 180,
///         heightSize: 260
///     )
/// )
/// ```
import SwiftUI

/// A design-system user card that shows a rounded avatar, name, and job description.
///
/// `DSUserCard` renders a decorative rotated rounded rectangle behind the avatar image, followed by the user's name and a caption with the job description. The entire card is tappable and executes the action provided by `DSUserCardModel.actionCallback`.
///
/// The appearance (spacing, radius, colors) is driven by the `dsTheme` environment.
public struct DSUserCard: View {
    @Environment(\.dsTheme) private var theme
    @Environment(\.colorScheme) private var scheme
    
    /// Internal layout constants for the decorative background and image sizing.
    private let rectangleWidth: CGFloat = 130
    private let rectangleHeight: CGFloat = 130
    private let opacityBackground: Double = 0.25
    private let rotationDegreesBackground: Double = 45
    private let imageSize: CGFloat = 150
    
    /// The configuration model that provides content, colors, dimensions, and tap action.
    public var personalCardModel: DSUserCardModel
    
    
    /// Creates a user card.
    /// - Parameter personalCardModel: The model describing the content and behavior of the card.
    public init(personalCardModel: DSUserCardModel) {
        self.personalCardModel = personalCardModel
    }
    
    /// The content and layout of the user card.
    public var body: some View {
        VStack(spacing: theme.spacing.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: theme.radius.lg)
                    .fill(personalCardModel.colorBackground)
                    .frame(width: rectangleWidth, height: rectangleHeight)
                    .rotationEffect(.degrees(rotationDegreesBackground))

                DSRoundedImage(.init(imageURL: personalCardModel.imageURL, size: imageSize))
            }

            VStack(spacing: theme.spacing.xs) {
                DSLabel(
                    .init(
                        text: personalCardModel.name, style: .accent
                    )
                )
                .padding(.top, theme.spacing.xs)

                DSLabel(
                    .init(
                        text: personalCardModel.jobDescription, style: .caption
                    )
                )
                .multilineTextAlignment(.center)
            }
        }
        .frame(width: personalCardModel.widthSize, height: personalCardModel.heightSize, alignment: .top)
        .padding(.trailing, theme.spacing.md)
        .contentShape(Rectangle())
        .onTapGesture { personalCardModel.actionCallback() }
    }
}

