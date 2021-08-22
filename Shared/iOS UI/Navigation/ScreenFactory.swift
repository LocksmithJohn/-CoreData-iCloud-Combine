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
            return AnyView(TasksScreen().environmentObject(container))
        case .projects:
            return AnyView(ProjectsScreen().environmentObject(container))
        case .inbox:
            return AnyView(InboxScreen().environmentObject(container))
        case .taskDetails:
            return AnyView(TaskDetailsScreen().environmentObject(container))
        case .projectDetails:
            return AnyView(ProjectDetailsScreen().environmentObject(container))
        case .inputDetails:
            return AnyView(InputDetailsScreen().environmentObject(container))
        }
    }
    
}
