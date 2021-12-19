//
//  TaskInteractor.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import Foundation

protocol TasksInteractorProtocol: InteractorProtocol { // TODO: w interaktorze powinno się znajdować więcej logiki biznesowej - tak jak w viewmodelu
        
    func add(name: String, description: String)
    func editCurrentTask(name: String, type: TaskType?)
    func editType(task: Task, taskType: TaskType)
    func deleteCurrentTask()
    func deleteTask(id: UUID)
    func deleteTasks()
    func setCurrentTask(id: UUID)

}

extension Interactor: TasksInteractorProtocol, ObservableObject {
    
    func add(name: String, description: String) {
        let newTask = Task(name: name,
                           description: description,
                           parentProject: "")
        coreDataManager.saveTask(task: newTask)
    }

    func setCurrentTask(id: UUID) {
        appState.currentTaskID = id
    }
    
    func deleteTasks() {
        coreDataManager.deleteAllTasks()
    }

    func deleteTask(id: UUID) {
        coreDataManager.deleteTask(id: id)
    }
    
    func deleteCurrentTask() {
        if let id = appState.currentTaskID {
            coreDataManager.deleteTask(id: id)
        }
    }
    
    func editCurrentTask(name: String, type: TaskType? = nil) {
        if let task = appState.getCurrentTask() {
            coreDataManager.editTask(id: task.id,
                                     taskName: name,
                                     taskDescription: "newTask.description",
                                     taskType: type?.name ?? task.taskType)
        }
    }

    func editType(task: Task, taskType: TaskType) {
        coreDataManager.editTask(id: task.id, taskType: taskType.name)
    }
    
}
