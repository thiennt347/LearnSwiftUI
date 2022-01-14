//
//  PersistentContainer.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/14/22.
//

import Foundation
import SwiftUI
import CoreData

class PersistentController {
    static let shared = PersistentController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "LearnSwiftUI")
        container.loadPersistentStores { _, error in
          if let error = error as NSError? {
            // You should add your own error handling code here.
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        }
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
      let context = container.viewContext
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          // The context couldn't be saved.
          // You should add your own error handling here.
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
    
    func delete(_ object: NSManagedObject) {
        let context = container.viewContext
        context.delete(object)
        self.saveContext()
    }
}
