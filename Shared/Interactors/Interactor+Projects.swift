//
//  ProjectsInteractor.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Foundation

protocol ProjectsInteractorProtocol: InteractorProtocol {
    
    func add(newName: String, newDescription: String, newTasks: [Task])
    func deleteProject(_ id: UUID)
    func editProject(newName: String, newDescription: String, newTasks: [Task])
    func setCurrentProject(id: UUID)
    func deleteAll()
    func deleteCurrentProject()
    
}

extension Interactor : ProjectsInteractorProtocol {
    
    func add(newName: String, newDescription: String, newTasks: [Task]) {
        let project = Project(id: UUID(),
                              name: newName,
                              description: newDescription,
                              tasks: newTasks)
        coreDataManager.saveProject(project: project)
        addTasksFromProject(project: project)
    }
    
    func deleteAll() {
        coreDataManager.deleteAllProjects()
    }

    func setCurrentProject(id: UUID) {
        appState.currentProjectID = id
    }

    func deleteProject(_ id: UUID) {
        coreDataManager.deleteProject(id: id)
    }
    
    func deleteCurrentProject() {
        if let id = appState.currentProjectID {
            coreDataManager.deleteProject(id: id)
        } else {
            // tutaj obsluga erra
        }
    }
    
    func editProject(newName: String,
                     newDescription: String,
                     newTasks: [Task]) {
        if let id = appState.currentProjectID {
            let project = Project(id: id, name: newName, description: newDescription, tasks: newTasks)
            coreDataManager.editProject(id: id, newProject: project)
        } else {
            // tutaj obsluga errora
        }
    }
    
    func adTaskToCurrentProject(task: Task) {
        if let currentID = appState.currentProjectID {
            coreDataManager.addTaskToProject(projectID: currentID, task: task)
        }
    }
    
    func addTasksFromProject(project: Project) {
        project.tasks.forEach {
            coreDataManager.saveTask(task: $0)
        }
    }
    
}
