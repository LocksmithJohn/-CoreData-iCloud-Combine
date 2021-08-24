//
//  CoreDataManager+Actions.swift
//  Trening_icloud3
//
//  Created by User on 24/08/2021.
//

import Foundation
import Combine
import CoreData

extension CoreDataManager {
    
    func saveTask(task: Task) {
        let task_cd = Task_CD(context: managedContext)
        task_cd.name = task.name
        task_cd.taskDescription = task.description
        saveContext()
    }
    
    func saveProject(project: Project) {
        let project_cd = Project_CD(context: managedContext)
        project_cd.name = project.name
        project_cd.projectDescription = project.description
        saveContext()
    }
    
    func deleteAllTasks() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task_CD")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                managedContext.delete(item)
            }

            try managedContext.save()

        } catch {
        }
    }
    
    func deleteAllProjects() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Project_CD")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                managedContext.delete(item)
            }

            try managedContext.save()

        } catch {
        }
    }
}
