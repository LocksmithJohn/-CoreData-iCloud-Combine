//
//  Project_CD+CoreDataProperties.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 07/09/2021.
//
//

import Foundation
import CoreData


extension Project_CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project_CD> {
        return NSFetchRequest<Project_CD>(entityName: "Project_CD")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var projectDescription: String?
    @NSManaged public var task: NSSet?
    
    var tasks_cd: [Task_CD] {
        let set = task as? Set<Task_CD> ?? []
        let ordered = set.sorted { $0.id < $1.id }

        return ordered
    }
    
    var tasks: [Task] {
        tasks_cd.compactMap { Task($0) }
    }
//
//    func saveTasks(_ tasks: [Task]) {
//        let tasks_cd = tasks.map { Task_CD($0) }
//        task = NSSet(tasks_cd)
//    }

}

// MARK: Generated accessors for task
extension Project_CD {

    @objc(addTaskObject:)
    @NSManaged public func addToTask(_ value: Task_CD)

    @objc(removeTaskObject:)
    @NSManaged public func removeFromTask(_ value: Task_CD)

    @objc(addTask:)
    @NSManaged public func addToTask(_ values: NSSet)

    @objc(removeTask:)
    @NSManaged public func removeFromTask(_ values: NSSet)

}

extension Project_CD : Identifiable {

}
