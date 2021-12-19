//
//  Task_CD+CoreDataProperties.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 07/09/2021.
//
//

import Foundation
import CoreData


extension Task_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task_CD> {
        return NSFetchRequest<Task_CD>(entityName: "Task_CD")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var taskType: String?
    @NSManaged public var origin: Project_CD?

}

extension Task_CD : Identifiable {

}
