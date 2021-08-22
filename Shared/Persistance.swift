//
//  Persistence.swift
//  Shared
//
//  Created by User on 07/08/2021.
//

import Combine
import CoreData

//class PersistenceController {
//    // A singleton for our entire app to use
//    static let shared = PersistenceController()
//
//    // Storage for Core Data
//    let container: NSPersistentContainer
//    var tasksBackSubject: CurrentValueSubject<[Task], Never> = CurrentValueSubject([])
//    var saveTaskSubject = PassthroughSubject<Task, Never>()
//    
//    private var bags = Set<AnyCancellable>()
//
//    // An initializer to load Core Data, optionally able
//    // to use an in-memory store.
//    init(inMemory: Bool = false) {
//        // If you didn't name your model Main you'll need
//        // to change this name below.
//        container = NSPersistentContainer(name: "Model")
//
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//        }
//
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Error: \(error.localizedDescription)")
//            }
//        }
//        
//        saveTaskSubject
//            .compactMap { [weak self] task -> Task_CD? in
//                guard let self = self else { return nil }
//                let task_cd = Task_CD(context: self.container.viewContext)
//                
//                task_cd.name = task.name
//                task_cd.taskDescription = task.description
//                task_cd.id = UUID()
//                
//                return task_cd
//            }
//            .sink { [weak self] task_cd in
//                try? self?.container.viewContext.save()
//            }
//            .store(in: &bags)
//    }
//    
//    private func save() {
//        let context = container.viewContext
//
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Show some error here
//            }
//        }
//    }
//    
//    func saveTask(_ task: Task) {
//        
//        let task_cd = Task_CD(context: container.viewContext)
//        
//        task_cd.name = task.name
//        task_cd.taskDescription = task.description
//        task_cd.id = UUID()
//        
//        try? container.viewContext.save()
//    }
//}
