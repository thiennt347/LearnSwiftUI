//
//  CategoryDB+CoreDataProperties.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 1/15/22.
//
//

import Foundation
import CoreData


extension CategoryDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryDB> {
        return NSFetchRequest<CategoryDB>(entityName: "CategoryDB")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageColor: String?
    @NSManaged public var imageName: String?
    @NSManaged public var name: String?
    @NSManaged public var totalTask: Int16
    @NSManaged public var taskDB: NSSet?
    
    public var tasks: [TaskDB] {
        let set = taskDB as? Set<TaskDB> ?? []
        
        return set.sorted {
            $0.taskName ?? "" < $1.taskName ?? ""
        }
    }

}

// MARK: Generated accessors for taskDB
extension CategoryDB {

    @objc(addTaskDBObject:)
    @NSManaged public func addToTaskDB(_ value: TaskDB)

    @objc(removeTaskDBObject:)
    @NSManaged public func removeFromTaskDB(_ value: TaskDB)

    @objc(addTaskDB:)
    @NSManaged public func addToTaskDB(_ values: NSSet)

    @objc(removeTaskDB:)
    @NSManaged public func removeFromTaskDB(_ values: NSSet)

}

extension CategoryDB : Identifiable {

}
