//
//  SType.swift
//  Light_Navigation_Architecture_on_Mac (iOS)
//
//  Created by User on 05/08/2021.
//

import SwiftUI

enum Route: Equatable { // for Mac
    
    case tasks(DetailsType)
    case projects(DetailsType)
    case inbox(DetailsType)
    
    enum DetailsType: Equatable {
        case creating
        case editing
    }
//
//    enum CanvasInboxType {
//        case creating
//        case editing(UUID)
//    }
//
//    enum CanvasProjectsType {
//        case creating
//        case editing(UUID)
//    }
    
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
