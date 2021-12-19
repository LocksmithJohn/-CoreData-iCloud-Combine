//
//  AppState.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import CoreData
import Foundation

//AppState
//AppState is the only entity in the pattern that requires to be an object, specifically, an ObservableObject. Alternatively, it can be a struct wrapped in a CurrentValueSubject from Combine.
//
//Just like with Redux, AppState works as the single source of truth and keeps the state for the entire app, including user’s data, authentication tokens, screen navigation state (selected tabs, presented sheets) and system state (is active / is backgrounded, etc.)
//
//AppState knows nothing about any other layer and does not contain any business logic.

class AppState: TasksAppStateProtocol,
                ProjectsAppStateProtocol,
                InputsAppStateProtocol,
                ObservableObject {

//    @Published var popupType: PopupType? = nil

    var currentProjectID: UUID?
    var currentTaskID: UUID?

    var tasksSubject: CurrentValueSubject<[Task], Never> = CurrentValueSubject([])
    var projectsSubject: CurrentValueSubject<[Project], Never> = CurrentValueSubject([])
    var inputsSubject: CurrentValueSubject<[Input], Never> = CurrentValueSubject([])
    var errors: [Error] = []
    var isTabbarVisibleSubject = CurrentValueSubject<Bool, Never>(true)

    var syncTimeSubject = PassthroughSubject<String?, Never>()

    private var projects = [Project]()  { didSet { projectsSubject.send(projects) }}
    private var inputs: [Input] = [] { didSet { inputsSubject.send(inputs) }}
    private var tasks: [Task] = [] { didSet {
        tasksSubject.send(tasks)
    }}
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
            }, receiveValue: { [weak self] tasks in
                self?.tasks = tasks.compactMap { Task($0) }
            })
            .store(in: &bags)
        
        coreDataManager.projectsSubject
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errors.append(error)
                }
            }, receiveValue: { projects in
                self.projects = projects.compactMap { Project($0) }
            })
            .store(in: &bags)
        
        coreDataManager.syncTimeSubject
            .sink { [weak self] timeValue in
                self?.syncTimeSubject.send(timeValue)
            }
            .store(in: &bags)
    }

}


