//
//  DSPrincipalHeaderModel.swift
//  NormanDSKit
//
//  Created by Norman on 25/12/25.
//

import SwiftUI

public struct DSPrincipalHeaderModel: Sendable {
    
    public var imageUrl: String
    public var name: String
    public var lastName: String
    public var email: String
    public var jobDescription: String
    public var jobTitle: String
    public var jobType: String
    public var personalDescription: String
    public var skills: [String]
    
    public init(imageUrl: String, name: String, lastName: String, email: String, jobDescription: String, jobTitle: String, jobType: String, personalDescription: String, skills: [String]) {
        self.imageUrl = imageUrl
        self.name = name
        self.lastName = lastName
        self.email = email
        self.jobDescription = jobDescription
        self.jobTitle = jobTitle
        self.jobType = jobType
        self.personalDescription = personalDescription
        self.skills = skills
    }
    
}
