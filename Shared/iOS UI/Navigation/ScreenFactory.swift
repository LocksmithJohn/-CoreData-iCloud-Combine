//
//  ScreenFactory.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct ScreenFactory {
    
    static func make(type: SType, container: Container) -> AnyView {
        switch type {
        case .tasks:
            return AnyView(TasksScreen(interactor: container.tasksInteractor,
                                       appState: container.appState,
                                       router: container.routerTasks))
        case .projects:
            return AnyView(ProjectsScreen(interactor: container.projectsInteractor,
                                          appState: container.appState,
                                          router: container.routerProjects))
        case .inbox:
            return AnyView(InboxScreen(interactor: container.inputsInteractor,
                                       appState: container.appState,
                                       router: container.routerInbox))
        case .taskDetails:
            return AnyView(TaskDetailsScreen().environmentObject(container))
        case .projectDetails:
            return AnyView(ProjectDetailsScreen().environmentObject(container))
        case .inputDetails:
            return AnyView(InputDetailsScreen().environmentObject(container))
        }
    }
    
}
