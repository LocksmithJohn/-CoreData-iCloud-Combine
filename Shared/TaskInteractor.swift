//
//  TaskInteractor.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine

protocol TasksInteractorProtocol {
    func add(task: Task)
}

class TasksInteractor: TasksInteractorProtocol, ObservableObject {
    
    var appState: AppState // tutaj powinien wjechac tylko cześć apstatea
    
    init(appstate: AppState) {
        self.appState = appstate
    }
    
    func add(task: Task) {
        appState.addTask(task)
    }
    
    func deleteTasks() {
        appState.deleteTasks()
    }
    
}
