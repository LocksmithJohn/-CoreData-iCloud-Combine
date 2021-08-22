//
//  SType.swift
//  Light_Navigation_Architecture_on_Mac (iOS)
//
//  Created by User on 05/08/2021.
//

import SwiftUI

enum MiddleType { // for Mac
    
    case tasks(CanvasTasksType)
    case projects(CanvasProjectsType)
    case inbox(CanvasInboxType)
    
    enum CanvasTasksType {
        case initial
        case details
    }
    
    enum CanvasInboxType {
        case initial
        case details
    }
    
    enum CanvasProjectsType {
        case initial
        case details
    }
    
    var title: String? {
        switch self {
        case .tasks:
            return "Tasks"
        case .projects:
            return "Projects"
        case .inbox:
            return "Inbox"
        }
    }
    
}
