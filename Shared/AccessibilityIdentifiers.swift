//
//  AccessibilityIdentifiers.swift
//  Trening_icloud3
//
//  Created by Jan Slusarz on 03/11/2021.
//

import Foundation

enum Identifier: String {

    // MARK: - Screen titles
    case screenTitleInbox = "screenTitleInbox"
    case screenTitleTasks = "screenTitleTasks"
    case screenTitleProjects = "screenTitleProjects"
    case screenTitleInboxDetails = "screenTitleInboxDetails"
    case screenTitleTaskDetails = "screenTitleTaskDetailsDetails"
    case screenTitleProjectDetails = "screenTitleProjectDetails"

    // MARK: - Tabbar
    case tabBarTabInbox = "tabBarTabInbox"
    case tabBarTabTasks = "tabBarTabTasks"
    case tabBarTabProjects = "tabBarTabProjects"

    var assertMessage: String {
        switch self {
        case .screenTitleTasks:
            return "Missing Tasks screen"
        case .screenTitleInbox:
            return "Missing Inbox screen"
        case .screenTitleProjects:
            return "Missing Projects screen"
        case .screenTitleInboxDetails:
            return "Missing Inbox Details screen"
        case .screenTitleTaskDetails:
            return "Missing Task Details screen"
        case .screenTitleProjectDetails:
            return "Missing Project Details screen"
        case .tabBarTabInbox:
            return "Missing Inbox Tab"
        case .tabBarTabTasks:
            return "Missing Tasks Tab"
        case .tabBarTabProjects:
            return "Missing Projects Tab"
        }
    }

}
