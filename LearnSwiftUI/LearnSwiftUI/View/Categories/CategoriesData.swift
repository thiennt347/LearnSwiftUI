//
//  DataModel.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/6/22.
//

import Foundation
import SwiftUI
import CoreData

struct CategoryModel: Hashable {
    let id: String? = nil
    let image: String
    let imageColor: String
    let name: String
    let numberTasks: Int
}

class CategoryViewModel: NSObject, ObservableObject {
    static let shared = CategoryViewModel()
    
    @Published var newCategory: Bool = false
    @Published var addNewTask: Bool = false
    @Published var editTask: Bool = false
    @Published var pickerImage: Bool = false
    @Published var pickerColor: Bool = false
    
    @Published var categories: [CategoryDB] = []
    
    func actionTask(taskDB: TaskDB? = nil,
                 taskName: String,
                 taskDate: Date,
                    note: String,
                    image: UIImage?,
                 category: CategoryDB,
                 context: NSManagedObjectContext) {
        let taskDB = taskDB != nil ? taskDB! : TaskDB(context: context)
        taskDB.id = UUID().uuidString
        taskDB.taskName = taskName
        taskDB.taskDate = taskDate
        taskDB.categoryID = category.id
        taskDB.categoryDB = category
        taskDB.note = note
        if let data = image?.pngData() {
            taskDB.image = data
        }
        try? context.save()
        NotificationManager.shared.scheduleNotification(task: taskDB)
    }
    
    func addCategory(categoryName: String,
                     icon: String,
                     color: Color,
                     context: NSManagedObjectContext) {
        
        var data = Hello(lists: ["asdasd"], aida: "asd")
        
        data.addData(data: "he")
        data.removeList(index: 0)
        
        let categoryDB = CategoryDB(context: context)
        categoryDB.id = UUID().uuidString
        categoryDB.imageColor = color.hexaRGB
        categoryDB.imageName = icon
        categoryDB.name = categoryName
        
        try? context.save()
    }
}
