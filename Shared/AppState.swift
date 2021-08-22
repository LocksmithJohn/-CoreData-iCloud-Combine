//
//  AppState.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import CoreData
import Foundation

class AppState {
    
    // AppState should be composed to different subcontext like screens in the future
    
//    let persistenceController = PersistenceController.shared
    let coreDataManager = CoreDataManager()
    
    var tasksSubject: CurrentValueSubject<[Task], Never> = CurrentValueSubject([]) // tutaj zrezygnowac w ogole z przetrzymywania, zapisywac z CoreData
    var projectsSubject: CurrentValueSubject<[Project], Never> = CurrentValueSubject([])
    var inputsSubject: CurrentValueSubject<[Input], Never> = CurrentValueSubject([])
    
    var syncTimeSubject = PassthroughSubject<String, Never>()


    private var projects = [Project]()  { didSet { projectsSubject.send(projects) }}
    private var inputs: [Input] = [] { didSet { inputsSubject.send(inputs) }}
    private var tasks: [Task] = [] { didSet { tasksSubject.send(tasks) }}


    private var bags = Set<AnyCancellable>()
    
    init() {
        coreDataManager.completion = { tasks_cd in
            self.tasks = tasks_cd.map { Task($0) }
        }
        
        coreDataManager.timerPublisher?
            .sink { date in
                self.syncTimeSubject.send(date ?? "_")
            }
            .store(in: &bags)
    }
    
    // MARK: - Adding functionality
    
    func saveTasks(_ tasks: [Task]) {
//        tasks.forEach {
//            persistenceController.saveTask($0)
//        }
    }
    
    func deleteTasks() {
        coreDataManager.deleteAllTasks()
    }
    
    func addTask(_ task: Task) {
//        persistenceController.saveTaskSubject.send(task)
//        addPerson(task)
        coreDataManager.saveTaskTest(task: task)
    }
    
    func addProject(_ project: Project) {
        projects.append(project)
    }
    
    func addInput(_ input: Input) {
        inputs.append(input)
    }
//
//    private func addPerson(_ task: Task) {
//         let action: Action = {
//             let task_CD: Task_CD = self.coreDataStore.createEntity()
//             task_CD.name = task.name
//         }
//
//         coreDataStore
//             .publicher(save: action)
//             .sink { completion in
//                 if case .failure(let error) = completion {
//                     print("filter Saving entities error: \(error.description)")
//                 }
//             } receiveValue: { success in
//                 if success {
//                     print("filter Saving entities succeeded")
//                     self.fetchTasks()
//                 }
//             }
//             .store(in: &bags)
//     }
//
//    private func fetchTasks() {
//        let request = NSFetchRequest<Task_CD>(entityName: Task_CD.entityName)
//        coreDataStore
//            .publicher(fetch: request)
//            .sink(receiveCompletion: { completion in
//                print("filter tasks compeltion: \(completion)")
//            }, receiveValue: { tasks_cd in
//                print("filter tasks: \(tasks_cd.map { $0.name })")
//                self.tasksSubject.send(tasks_cd.map { Task($0) })
//            })
//            .store(in: &bags)
//    }
    
    
}


