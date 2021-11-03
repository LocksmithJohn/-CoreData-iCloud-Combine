//
//  InputInteractor.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 04/08/2021.
//

import Foundation

protocol InputInteractorProtocol: InteractorProtocol {
//    func add(input: Input)
//    func edit(id: UUID, newTask: Task)
//    func deleteTask(id: UUID)
}

class InputInteractor: InputInteractorProtocol {
//    func edit(id: UUID, newTask: Task) {
//        appState.editTask(id, newTask: newTask)
//    }
//    
//    func deleteTask(id: UUID) {
//        appState.deleteTask(id)
//    }
    

    var appState: AppState

    init(appstate: AppState) {
        self.appState = appstate
    }

//    func add(input: Input) {
//        appState.addInput(input)
//    }

}
