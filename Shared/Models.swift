//
//  Models.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//
import CoreData
import Foundation

struct Project: Equatable {
    var name: String = ""
    var description: String? = nil
    var tasks: [Task]
}

struct Task: Equatable {
    var name: String = ""
    var description: String? = nil
    var parentProject: String = ""
}

extension Project {
    init(_ project_cd: Project_CD) {
        name = project_cd.name ?? ""
        description = project_cd.projectDescription
        tasks = []
    }
}

extension Task {
    init(_ task_cd: Task_CD) {
        name = task_cd.name ?? ""
        description = task_cd.taskDescription
    }
}
//
//extension Task_CD {
//    init(_ task: Task) {
////        super.init()
//        name = task.name
//        taskDescription = task.description
//    }
//}

struct Input: Equatable {
    var name: String = ""
    var description: String? = nil
}

