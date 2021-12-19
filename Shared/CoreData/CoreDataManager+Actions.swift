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
        
    // MARK: - Save actions

    func saveTask(task: Task) {
        let task_cd = Task_CD(context: managedContext)
        task_cd.id = task.id
        task_cd.name = task.name
        task_cd.taskDescription = task.description
        saveContext()
    }
    
    func saveProject(project: Project) {
        let project_cd = Project_CD(context: managedContext)
        project_cd.name = project.name
        project_cd.projectDescription = project.description
        project_cd.id = project.id
        project.tasks.forEach {
            let task_cd = Task_CD(context: managedContext)
            task_cd.id = $0.id
            task_cd.name = $0.name
            task_cd.taskDescription = $0.description
            project_cd.addToTask(task_cd)
        }
        saveContext()
    }
    
    func addTaskToProject(projectID: UUID, task: Task) {
        guard let gotProject = getProject(id: projectID) else {
            return // TODO: error
        }
        var editedProject = gotProject
        editedProject.tasks.append(task)
        editProject(id: projectID,
                    newName: editedProject.name,
                    newDescription: editedProject.description,
                    newTasks: editedProject.tasks)
    }
    
    // MARK: - Get actions
    
    func getProject(id: UUID) -> Project? {
        let request: NSFetchRequest<Project_CD> = Project_CD.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)

        if let project_cd = try? managedContext.fetch(request).first {
            return Project(project_cd)
        }
        
        return nil
    }
    
    func getItems(entityType: EntityType) -> [NSManagedObject] {
        let className = String(describing: entityType.type.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: className)
        let objects = (try? managedContext.fetch(request))
        let entities = objects as? [NSManagedObject]
        return entities ?? []
    }
    
    // MARK: - Edit actions
    
    func editProject(id: UUID,
                     newName: String? = nil,
                     newDescription: String? = nil,
                     newTasks: [Task]? = nil) {
        let request: NSFetchRequest<Project_CD> = Project_CD.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)

        if let project_cd = try? managedContext.fetch(request).first {
            if let newName = newName {
                project_cd.name = newName
            }
            if let newDescription = newDescription {
                project_cd.projectDescription = newDescription
            }
            if let newTasks = newTasks {
                newTasks.forEach {
                    guard !(project_cd.tasks.map { $0.id }).contains($0.id) else { return }

                    let task_cd = Task_CD(context: managedContext)
                    task_cd.id = $0.id
                    task_cd.name = $0.name
                    task_cd.taskDescription = $0.description
                    task_cd.taskType = $0.taskType
                    project_cd.addToTask(task_cd)
                }
            }
            saveContext()
        }
    }

    func editTaskInProject(projectId: UUID,
                           taskId: UUID,
                           taskName: String? = nil,
                           taskDescription: String? = nil,
                           taskType: TaskType? = nil) {
        let request: NSFetchRequest<Project_CD> = Project_CD.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", projectId.uuidString)

        if let project_cd = try? managedContext.fetch(request).first {
            project_cd.tasks_cd.forEach {
                if $0.id == taskId {
                    editTask(id: taskId,
                             taskName: taskName,
                             taskDescription: taskDescription,
                             taskType: taskType?.name)
                }
            }
            project_cd.name = project_cd.name // TODO: zrefaktorowac to. nazwa projektu jest zmieniona tylko po to aby odswiezyc subject projektowy
            saveContext()
        }
    }
    
    func editTask(id: UUID,
                  taskName: String? = nil,
                  taskDescription: String? = nil,
                  taskType: String? = nil) {
        let request: NSFetchRequest<Task_CD> = Task_CD.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)

        if let task_cd = try? managedContext.fetch(request).first {
            if let newName = taskName {
                task_cd.setValue(newName, forKey: "name")
            }
            if let newType = taskType {
                task_cd.setValue(newType, forKey: "taskType")
            }
            if let newDescription = taskDescription {
                task_cd.setValue(newDescription, forKey: "taskDescription")
            }
            saveContext()
        }
    }
    
    // MARK: - Delete actions
    
    func deleteTask(id: UUID) {
        let request: NSFetchRequest<Task_CD> = Task_CD.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)

        if let task_cd = try? managedContext.fetch(request).first {
            managedContext.delete(task_cd)
            saveContext()
        }
    }
    
    func deleteProject(id: UUID) {
        let request: NSFetchRequest<Project_CD> = Project_CD.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)

        if let project_cd = try? managedContext.fetch(request).first {
            managedContext.delete(project_cd)
            saveContext()
        }
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
