//
//  Container.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI

class Container: ObservableObject {
    
    let dateManager = DateManager()
    let appState: AppState
    let coreDataManager: CoreDataManager
    let tasksInteractor: TasksInteractor
    let projectsInteractor: ProjectsInteractor
    let inputsInteractor: InputInteractor

#if os(iOS)
    let routerInbox = IOSRouter()
    let routerTasks = IOSRouter()
    let routerProjects = IOSRouter()
#elseif os(macOS)
    @Published var router = IOSRouter() // tutaj logikę tego routera trzeba jakos zmienic
#endif
    
    init() {
        self.coreDataManager = CoreDataManager(dateManager: dateManager)
        self.appState = AppState(coreDataManager: coreDataManager)
        self.tasksInteractor = TasksInteractor(appstate: appState)
        self.projectsInteractor = ProjectsInteractor(appstate: appState)
        self.inputsInteractor = InputInteractor(appstate: appState)
        let asdf = \AppState.errors
    }
    
}
