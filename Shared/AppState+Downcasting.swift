//
//  AppState+Downcasting.swift
//  Trening_icloud3
//
//  Created by User on 25/08/2021.
//

import Combine
import Foundation

protocol TasksAppStateProtocol {

    var tasksSubject: CurrentValueSubject<[Task], Never> { get }
    var syncTimeSubject: PassthroughSubject<String?, Never> { get }
    var currentTaskID: UUID? { set get }
    
    func getCurrentTask() -> Task?

}

extension TasksAppStateProtocol {
    
    func getCurrentTask() -> Task? {
        tasksSubject.value.first { $0.id == currentTaskID }
    }
    
}


protocol ProjectsAppStateProtocol {

    var projectsSubject: CurrentValueSubject<[Project], Never> { get }
    var currentProjectID: UUID? { set get }
    var syncTimeSubject: PassthroughSubject<String?, Never> { get }

    func getCurrentProject() -> Project?
    func getNextActions() -> [Task]
    func getWaitingFors() -> [Task]
    func getNotes() -> String

}

extension ProjectsAppStateProtocol {
    
    func getCurrentProject() -> Project? {
        projectsSubject.value
            .first { $0.id == currentProjectID }
    }

    func getCurrentProject() -> AnyPublisher<Project, Never> {
        projectsSubject
            .compactMap { projects in
                projects.first { project in
                    project.id == currentProjectID
                }
            }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    func getNotes() -> String {
        projectsSubject.value
            .first { $0.id == currentProjectID }?.description ?? ""
    }

    func getNextActions() -> [Task] {
        projectsSubject.value
            .first { $0.id == currentProjectID }?.tasks
            .filter { $0.taskType == TaskType.nextAction.name } ?? []
    }

    func getWaitingFors() -> [Task] {
        projectsSubject.value
            .first { $0.id == currentProjectID }?.tasks
            .filter { $0.taskType == TaskType.waitingFor.name } ?? []
    }
    
}

protocol InputsAppStateProtocol {

    var inputsSubject: CurrentValueSubject<[Input], Never> { get }

}
