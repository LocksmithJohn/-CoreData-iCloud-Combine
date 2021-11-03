//
//  TaskInteractor.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import Foundation

protocol TasksInteractorProtocol: InteractorProtocol {
        
    func add(task: Task)
    func edit(id: UUID, newTask: Task)
    func deleteCurrentTask()
    func setCurrentTask(id: UUID)
    func deleteTasks()
    
}

extension Interactor: TasksInteractorProtocol, ObservableObject {
    
    func add(task: Task) {
        coreDataManager.saveTask(task: task)
    }

    func setCurrentTask(id: UUID) {
        appState.currentTaskID = id
    }
    
    func deleteTasks() {
        coreDataManager.deleteAllTasks()
    }
    
    func deleteCurrentTask() {
        if let id = appState.currentTaskID {
            coreDataManager.deleteTask(id: id)
        }
    }
    
    func edit(id: UUID, newTask: Task) {
        coreDataManager.editTask(id: id, newTask: newTask)
    }
    
}
