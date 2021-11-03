//
//  SType.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Foundation

enum IOS_SType { // for iPhone
    case tasks
    case taskDetails
    case projects
    case projectDetails
    case projectCreate
    case inbox
    case inputDetails
    
    var title: String? {
        switch self {
        case .tasks:
            return "Tasks"
        case .projects:
            return "Projects"
        case .inbox:
            return "Inbox"
        case .taskDetails:
            return "Task details"
        case .projectDetails:
            return "Project details"
        case .inputDetails:
            return "Input details"
        case .projectCreate:
            return "Create Project"
        }
    }
}
