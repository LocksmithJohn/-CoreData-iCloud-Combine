//
//  ScreenFactory.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct ScreenFactory {
    static func make(type: IOS_SType, container: Container) -> AnyView {
        handleTabbarVisibility(sType: type, container: container)
        switch type {
        case .tasks:
            return AnyView(IOS_TasksScreen(appState: container.appState,
                                           interactor: container.interactor,
                                           router: container.routerTasks))
        case .projects:
            return AnyView(IOS_ProjectsScreen(interactor: container.interactor,
                                              appState: container.appState,
                                              router: container.routerProjects))
        case .inbox:
            return AnyView(IOS_InboxScreen(interactor: container.interactor,
                                           appState: container.appState,
                                           router: container.routerInbox))
        case .taskDetails:
            return AnyView(IOS_TaskDetailsScreen(interactor: container.interactor,
                                                 appState: container.appState,
                                                 type: .taskDetails,
                                                 router: container.routerTasks))
        case .taskCreate:
            return AnyView(IOS_TaskDetailsScreen(interactor: container.interactor,
                                                 appState: container.appState,
                                                 type: .taskCreate,
                                                 router: container.routerTasks))
        case .projectDetails:
            return AnyView(IOS_ProjectDetailsScreen(projectsInteractor: container.interactor,
                                                    tasksInteractor: container.interactor,
                                                    appState: container.appState,
                                                    type: .projectDetails,
                                                    router: container.routerProjects))
        case .projectCreate:
            return AnyView(IOS_ProjectDetailsScreen(projectsInteractor: container.interactor,
                                                    tasksInteractor: container.interactor,
                                                    appState: container.appState,
                                                    type: .projectCreate,
                                                    router: container.routerProjects))
        case .inputDetails:
            return AnyView(IOS_InputDetailsScreen().environmentObject(container))
        }
    }

    static func handleTabbarVisibility(sType: IOS_SType, container: Container) {
        var visible: Bool {
            switch sType {
            case .tasks,
                    .projects,
                    .inbox:
                return true
            default:
                return false
            }
        }
//    TODO: - obsluzyc tabbar jak bedzie czas
//        container.appState.isTabbarVisibleSubject.send(visible)
    }

}
