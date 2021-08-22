//
//  Persistence.swift
//  Shared
//
//  Created by User on 07/08/2021.
//
import Combine
import CoreData

//struct PersistenceControllerTest {
//    // A singleton for our entire app to use
//    static let shared = PersistenceControllerTest()
//
//    // Storage for Core Data
//    let container: NSPersistentContainer
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
//        let task_cd = Task_CD(context: container.viewContext)
//        
//        task_cd.name = task.name
//        task_cd.taskDescription = task.description
//        task_cd.id = UUID()
//        
//        try? container.viewContext.save()
//    }
//    
//    func combineSave() {
//        let task_cd = Task_CD(context: container.viewContext)
//        
////        objectSubject.send(task_cd)tutaj sprobowac wysylajac event wykonac takze zapis do coredaty
////            i zwrocic event z wynikowa wartoscia
//    }
//    
//    private let objectSubject = PassthroughSubject<NSManagedObject, Never>()
//    var objectPublisher: AnyPublisher<NSManagedObject, Never> {
//        objectSubject.eraseToAnyPublisher()
//    }
//    
//}
