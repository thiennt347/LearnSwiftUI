//
//  SideMenuViewModel.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/5/22.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case Home
    case Templates
    case Categories
    case Analytics
    case Settings
    
    var title: String {
        switch self {
        case .Home: return "Home"
        case .Templates: return "Templates"
        case .Categories: return "Categories"
        case .Analytics: return "Analytics"
        case .Settings: return "Settings"
        }
    }
    
    var imageName: String {
        switch self {
        case .Home: return "house"
        case .Templates: return "doc.plaintext"
        case .Categories: return "dpad"
        case .Analytics: return "clock"
        case .Settings: return "gearshape"
        }
    }
}
