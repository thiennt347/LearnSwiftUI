//
//  TaskDB+CoreDataProperties.swift
//  LearnSwiftUI
//
//  Created by Duong Pham on 2/23/22.
//
//

import Foundation
import CoreData


extension TaskDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskDB> {
        return NSFetchRequest<TaskDB>(entityName: "TaskDB")
    }

    @NSManaged public var categoryID: String?
    @NSManaged public var id: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var taskDate: Date?
    @NSManaged public var taskName: String?
    @NSManaged public var note: String?
    @NSManaged public var image: Data?
    @NSManaged public var categoryDB: CategoryDB?

}

extension TaskDB : Identifiable {

}
