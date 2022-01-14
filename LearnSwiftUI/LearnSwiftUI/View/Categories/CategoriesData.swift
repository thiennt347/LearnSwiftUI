//
//  DataModel.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/6/22.
//

import Foundation
import SwiftUI

struct CategoryModel: Hashable {
    let id: String? = nil
    let image: String
    let imageColor: String
    let name: String
    let numberTasks: Int
}

class CategoryViewModel: ObservableObject {

    static let shared = CategoryViewModel()
    
    @Published var newCategory: Bool = false
    @Published var pickerImage: Bool = false
    @Published var pickerColor: Bool = false
    
    @Published var categories: [CategoryModel] = []
    
    @FetchRequest(
      // 2.
      entity: CategoryDB.entity(),
      // 3.
      sortDescriptors: []
      //,predicate: NSPredicate(format: "genre contains 'Action'")
      // 4.
    ) var categoriesDB: FetchedResults<CategoryDB>
    
}
