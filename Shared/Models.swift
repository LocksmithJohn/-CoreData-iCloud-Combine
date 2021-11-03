//
//  Models.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//
import CoreData
import Foundation

struct Project: Equatable, Identifiable, Hashable {
    var id: UUID
    var name: String = ""
    var description: String? = nil
    var tasks: [Task]
}

struct Task: Equatable, Identifiable, Hashable {
    var id: UUID
    var name: String = ""
    var description: String? = nil
    var parentProject: String = "" // tutaj zmienic na uuid projectu
}

extension Project {
    init?(_ project_cd: Project_CD) {
        guard let id = project_cd.id else { return nil }
        
        self.name = project_cd.name ?? ""
        self.description = project_cd.projectDescription
        self.id = id
        self.tasks = project_cd.tasks
    }
}

extension Project_CD {
    convenience init(_ project: Project) {
        self.init()
        name = project.name
        projectDescription = project.description
//        saveTasks(project.tasks)
    }
}

extension Task {
    init?(_ task_cd: Task_CD) {
        guard let id = task_cd.id else { return nil }
        
        self.id = id
        self.name = task_cd.name ?? ""
        self.description = task_cd.taskDescription
    }
}


extension Task_CD {
    convenience init(_ task: Task) {
        self.init()
        self.name = task.name // tutaj sie wypieprza
        self.taskDescription = task.description
    }
}

struct Input: Equatable {
    var name: String = ""
    var description: String? = nil
}

