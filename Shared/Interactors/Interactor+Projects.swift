//
//  ProjectsInteractor.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Foundation

protocol ProjectsInteractorProtocol: InteractorProtocol {
    
    func add(newName: String, newDescription: String, newTasks: [Task])
    func addTaskToCurrentProject(task: Task)

    func deleteProject(_ id: UUID)
    func deleteCurrentProject()
    func deleteAll()

    func editCurrentProject(newName: String?, newDescription: String?, newTasks: [Task]?)
    func editTypeInTaskInCurrentProject(taskId: UUID?, taskType: TaskType?)

    func setCurrentProject(id: UUID?)

}

extension Interactor : ProjectsInteractorProtocol {

    func add(newName: String, newDescription: String, newTasks: [Task]) {
        let project = Project(id: UUID(),
                              name: newName,
                              description: newDescription,
                              tasks: newTasks)
        coreDataManager.saveProject(project: project)
    }
    
    func deleteAll() {
        coreDataManager.deleteAllProjects()
    }

    func setCurrentProject(id: UUID?) {
        appState.currentProjectID = id
    }

    func deleteProject(_ id: UUID) {
        coreDataManager.deleteProject(id: id)
    }
    
    func deleteCurrentProject() {
        if let id = appState.currentProjectID {
            coreDataManager.deleteProject(id: id)
        } else {
            // TODO: obsluga erra
        }
    }
    
    func editCurrentProject(newName: String? = nil,
                     newDescription: String? = nil,
                     newTasks: [Task]? = nil) {
        if let id = appState.currentProjectID {
            coreDataManager.editProject(id: id,
                                        newName: newName,
                                        newDescription: newDescription,
                                        newTasks: newTasks)
        } else { }
    }
    
    func addTaskToCurrentProject(task: Task) {
        if let currentID = appState.currentProjectID {
            coreDataManager.addTaskToProject(projectID: currentID, task: task)
        }
    }
    
    func editTypeInTaskInCurrentProject(taskId: UUID?, taskType: TaskType?) {
        if let currentProjectID = appState.currentProjectID,
           let taskId = taskId {
            coreDataManager.editTaskInProject(projectId: currentProjectID,
                                              taskId: taskId,
                                              taskType: taskType)
        }
    }
    
}
