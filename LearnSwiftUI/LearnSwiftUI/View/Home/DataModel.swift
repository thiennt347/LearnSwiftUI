//
//  HorizontalData.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 12/30/21.
//

import Foundation
import SwiftUI

enum TaskType: String {
    case Business = "Business"
    case Personal = "Personal"
    case Team = "Team"
}

struct HorizontalData: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var name: String
    var progress: CGFloat
}

struct TodayTask: Hashable, Codable, Identifiable {
    var id: Int
    var status: Int
    var name: String
    var taskType: String
}
