//
//  AppState+Downcasting.swift
//  Trening_icloud3
//
//  Created by User on 25/08/2021.
//

import Combine
import Foundation

protocol TasksAppStateProtocol {// tutaj do oddzielnych plikow

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

}

extension ProjectsAppStateProtocol {
    
    func getCurrentProject() -> Project? {
        projectsSubject.value.first { $0.id == currentProjectID }
    }
    
}

protocol InputsAppStateProtocol {

    var inputsSubject: CurrentValueSubject<[Input], Never> { get }

}
