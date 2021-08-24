//
//  AppState.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import CoreData
import Foundation

class AppState: TasksAppState,
                ProjectsAppState,
                InputsAppState,
                ObservableObject {
    
    
    var tasksSubject: CurrentValueSubject<[Task], Never> = CurrentValueSubject([])
    var projectsSubject: CurrentValueSubject<[Project], Never> = CurrentValueSubject([])
    var inputsSubject: CurrentValueSubject<[Input], Never> = CurrentValueSubject([])
    var syncTimeSubject = MyPassthroughSubject<String?>()
    var errors: [Error] = []

    private var projects = [Project]()  { didSet { projectsSubject.send(projects) }}
    private var inputs: [Input] = [] { didSet { inputsSubject.send(inputs) }}
    private var tasks: [Task] = [] { didSet { tasksSubject.send(tasks) }}
    private var bags = Set<AnyCancellable>()
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        bindCoreData()
    }
    
    // MARK: - Private methods
    
    private func bindCoreData() {
        coreDataManager.tasksSubject
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errors.append(error)
                }
            }, receiveValue: { tasks in
                self.tasks = tasks.map { Task($0) }
            })
            .store(in: &bags)
        
        coreDataManager.projectsSubject
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errors.append(error)
                }
            }, receiveValue: { projects in
                self.projects = projects.map { Project($0) }
            })
            .store(in: &bags)
        
        coreDataManager.syncTimeSubject
            .sink { [weak self] timeValue in
                self?.syncTimeSubject.send(timeValue)
            }
            .store(in: &bags)
    }
    
    // MARK: - Adding functionality
    
    func addTask(_ task: Task) {
        coreDataManager.saveTask(task: task)
    }
    
    func addProject(_ project: Project) {
        coreDataManager.saveProject(project: project)
    }
    
    // MARK: - Deleting functionality
    
    func deleteTasks() {
        coreDataManager.deleteAllTasks()
    }
    
    func deleteProjects() {
        coreDataManager.deleteAllProjects()
    }
    
}


