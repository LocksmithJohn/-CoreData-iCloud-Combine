//
//  AppState.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import CoreData
import Foundation

class AppState: TasksAppStateProtocol,
                ProjectsAppStateProtocol,
                InputsAppStateProtocol,
                ObservableObject {

    var currentProjectID: UUID?
    var currentTaskID: UUID?

    var tasksSubject: CurrentValueSubject<[Task], Never> = CurrentValueSubject([])
    var projectsSubject: CurrentValueSubject<[Project], Never> = CurrentValueSubject([])
    var inputsSubject: CurrentValueSubject<[Input], Never> = CurrentValueSubject([])
    var syncTimeSubject = PassthroughSubject<String?, Never>()
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
        print("filterr    AppState: core data binded")
        coreDataManager.tasksSubject
            .sink(receiveCompletion: { [weak self] completion in
                print("filterr    AppState: tasks completion received")
                if case .failure(let error) = completion {
                    self?.errors.append(error)
                }
            }, receiveValue: { tasks in
                print("filterr    AppState: tasks received")
                self.tasks = tasks.compactMap { Task($0) }
            })
            .store(in: &bags)
        
        coreDataManager.projectsSubject
            .sink(receiveCompletion: { [weak self] completion in
                print("filterr    AppState:  projects completion received")
                if case .failure(let error) = completion {
                    self?.errors.append(error)
                }
            }, receiveValue: { projects in
                print("filterr    AppState:  projects received")
                self.projects = projects.compactMap { Project($0) }
            })
            .store(in: &bags)
        
        coreDataManager.syncTimeSubject
            .sink { [weak self] timeValue in
                self?.syncTimeSubject.send(timeValue)
            }
            .store(in: &bags)
    }
    // tutaj poniższe akcje chyba nie powinny byc w appstacie moze odrazu w interaktorach
    
//    // MARK: - Getting functionality
//
//    func reloadTaskss() {
////        coreDataManager.fetchData(entityType: .task)
//    }
//
//    func reloadProjectss() {
////        coreDataManager.fetchData(entityType: .project)
//    }
//
//    // MARK: - Adding functionality
//
//    func addTask(_ task: Task) {
//        coreDataManager.saveTask(task: task)
//    }
//
//    func addTaskToProject(task: Task) {
//        guard let id = currentProjectID,
//              let gotProject = coreDataManager.getProject(id: id) else {
//            return // tutaj error
//        }
//        var editedProject = gotProject
//        editedProject.tasks.append(task)
//        coreDataManager.editProject(id: id, newProject: editedProject)
//    }
//
//    func addProject(_ project: Project) {
//        coreDataManager.saveProject(project: project)
//    }
//
//    // MARK: - Modifying functionality
////    func editInput(_ id: UUID, newInput: Input) {
////        coreDataManager.editTask(id: id, newName: newTask.name)
////    }
//
//    func editTask(_ id: UUID, newTask: Task) {
//        coreDataManager.editTask(id: id, newName: newTask.name)
//    }
//
//    func editProject(name: String,
//                     description: String,
//                     tasks: [Task]) {
//        if let id = currentProjectID {
//            let project = Project(id: id, name: name, description: description, tasks: tasks)
//            coreDataManager.editProject(id: id, newProject: project)
//        } else {
//            // tutaj obsluga erra
//        }
//    }
    
//    // MARK: - Deleting functionality
//
//    func deleteTask(_ id: UUID) {
//        coreDataManager.deleteTask(id: id)
//    }
//
//    func deleteCurrentProject() {
//        if let id = currentProjectID {
//            coreDataManager.deleteProject(id: id)
//        } else {
//            // tutaj obsluga erra
//        }
//    }
//
//    func deleteProject(_ id: UUID) {
//        coreDataManager.deleteProject(id: id)
//    }
//
//    func deleteTasks() {
//        coreDataManager.deleteAllTasks()
//    }
//
//    func deleteProjects() {
//        coreDataManager.deleteAllProjects()
//    }
    
}


