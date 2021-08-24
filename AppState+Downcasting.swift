//
//  AppState+Downcasting.swift
//  Trening_icloud3
//
//  Created by User on 25/08/2021.
//

import Combine

protocol TasksAppState {
    
    var tasksSubject: CurrentValueSubject<[Task], Never> { get }
    var syncTimeSubject: MyPassthroughSubject<String?> { get }
    
}

protocol ProjectsAppState {
    
    var projectsSubject: CurrentValueSubject<[Project], Never> { get }
    
}

protocol InputsAppState {
    
    var inputsSubject: CurrentValueSubject<[Input], Never> { get }
    
}
