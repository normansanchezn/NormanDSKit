//
//  DSPrincipalHeaderModel.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

/// A data model for `DSPrincipalHeader` describing the hero image and profile details.
///
/// Use `DSPrincipalHeaderModel` to provide the background image URL and personal
/// information shown in the header overlay.
///
/// ### Example
/// ```swift
/// let model = DSPrincipalHeaderModel(
///     imageUrl: "https://example.com/photo.jpg",
///     name: "Norman",
///     lastName: "Sanchez",
///     email: "norman@example.com",
///     jobDescription: "Mentor & iOS Engineer",
///     jobTitle: "iOS Engineer",
///     jobType: "Full-time",
///     personalDescription: "Passionate about building great apps.",
///     skills: ["Swift", "SwiftUI", "Design Systems"]
/// )
/// ```
public struct DSPrincipalHeaderModel: Sendable {
    
    /// Background image URL for the hero header.
    public var imageUrl: String
    /// First name.
    public var name: String
    /// Last name.
    public var lastName: String
    /// Email address.
    public var email: String
    /// Short job description or summary.
    public var jobDescription: String
    /// Job title (e.g., "iOS Engineer").
    public var jobTitle: String
    /// Job type (e.g., "Full-time").
    public var jobType: String
    /// Short personal description.
    public var personalDescription: String
    /// List of skills to display.
    public var skills: [String]
    public var rank: String?
    
    /// Creates a principal header model.
    /// - Parameters:
    ///   - imageUrl: Background image URL for the hero header.
    ///   - name: First name.
    ///   - lastName: Last name.
    ///   - email: Email address.
    ///   - jobDescription: Short job description or summary.
    ///   - jobTitle: Job title (e.g., "iOS Engineer").
    ///   - jobType: Job type (e.g., "Full-time").
    ///   - personalDescription: Short personal description.
    ///   - skills: List of skills to display.
    public init(
        imageUrl: String,
        name: String,
        lastName: String,
        email: String,
        jobDescription: String,
        jobTitle: String,
        jobType: String,
        personalDescription: String,
        skills: [String],
        rank: String? = nil
    ) {
        self.imageUrl = imageUrl
        self.name = name
        self.lastName = lastName
        self.email = email
        self.jobDescription = jobDescription
        self.jobTitle = jobTitle
        self.jobType = jobType
        self.personalDescription = personalDescription
        self.skills = skills
        self.rank = rank
    }
    
}
