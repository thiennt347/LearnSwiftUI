//
//  TaskViewModel.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/13/22.
//

import Foundation
struct TaskSection: Identifiable {
    var id = UUID()
    var title: String
    var items: [TaskDB]
}

struct Task: Identifiable {
    var id: String? = nil
    var taskName: String
    var taskDate: Date = Date.now
    var isComplete: Bool = false
}

class TaskViewModel: ObservableObject {
    //addNew task
    static let shared = TaskViewModel()
    
    @Published var addNewTask: Bool = false
    
    @Published var taskData = [
        TaskSection(title: "Late", items: []),
        
        TaskSection(title: "Today", items: []),
        
        TaskSection(title: "Done", items: [])
    ]
}
