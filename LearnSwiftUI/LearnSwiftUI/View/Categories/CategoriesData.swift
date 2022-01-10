//
//  DataModel.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/6/22.
//

import Foundation
import SwiftUI

struct CategoryModel: Hashable {
    let image: String
    let imageColor: Color
    let name: String
    let numberTasks: Int
}

class CategoryViewModel: ObservableObject {
    @Published var categories = [CategoryModel(image: "wallet.pass",
                                        imageColor: .blue,
                                        name: "All", numberTasks: 23),
                          CategoryModel(image: "bag",
                                     imageColor: .orange,
                                     name: "Work", numberTasks: 14),
                          CategoryModel(image: "beats.headphones",
                                     imageColor: .orange.opacity(0.7),
                                     name: "Music", numberTasks: 6),
                          CategoryModel(image: "book.closed",
                                     imageColor: .purple.opacity(0.5),
                                     name: "Study", numberTasks: 0),
                          CategoryModel(image: "house.circle",
                                     imageColor: .yellow.opacity(0.7),
                                     name: "Home", numberTasks: 10),
                          CategoryModel(image: "paintpalette",
                                     imageColor: .purple,
                                     name: "Pain", numberTasks: 2),
                          CategoryModel(image: "globe.americas.fill",
                                     imageColor: .green,
                                     name: "Trekking", numberTasks: 8),
                          CategoryModel(image: "message",
                                     imageColor: .gray,
                                     name: "Chat", numberTasks: 9),
    ]
    static let shared = CategoryViewModel()
}
