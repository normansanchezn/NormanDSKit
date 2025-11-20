//
//  DSInfoModel.swift
//  NormanDSKit
//
//  Created by Norman Sanchez on 17/11/25.
//

import SwiftUI

public struct DSInfoModel: Identifiable {
    public var id: UUID = UUID()
    public var title: String
    public var subtitle: String
    public var image: Image?
}
