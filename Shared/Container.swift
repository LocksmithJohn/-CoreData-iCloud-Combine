//
//  Container.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI

class Container: ObservableObject {
    
    let appState = AppState()
    
    let taskInteractor: TasksInteractor
    let projectsInteractor: ProjectsInteractor
    let inputsInteractor: InputInteractor

#if os(iOS)
    let routerInbox = Router()
    let routerTasks = Router()
    let routerProjects = Router()
#elseif os(macOS)
    @Published var router = Router() // tutaj logikę tego routera trzeba jakos zmienic
#endif
    
    init() {
        self.taskInteractor = TasksInteractor(appstate: appState)
        self.projectsInteractor = ProjectsInteractor(appstate: appState)
        self.inputsInteractor = InputInteractor(appstate: appState)
    }
    
}
