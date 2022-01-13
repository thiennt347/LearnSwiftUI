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
    var items: [Task]
}

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var date: Date = Date.now
    var isDone: Bool = false
}

class TaskViewModel: ObservableObject {
    //addNew task
    static let shared = TaskViewModel()
    
    @Published var addNewTask: Bool = false
    
    @Published var taskData = [
        TaskSection(title: "Late", items: [
            Task(title: "Call Max", date: .now, isDone: false)
        ]),
        
        TaskSection(title: "Today", items: [
            Task(title: "Practice piano", date: .now, isDone: false),
            Task(title: "Learn Spanish", date: .now, isDone: false)
            
        ]),
        TaskSection(title: "Done", items: [
            Task(title: "Finalize presentation", date: .now, isDone: true)
        ])
    ]
}
