//
//  YetAnotherCoreDataTest.swift
//  Trening_icloud3
//
//  Created by User on 18/08/2021.
//

import Foundation
import Combine
import CoreData

class CoreDataManager: NSObject {
        
    var completion: (([Task_CD]) ->  Void)?
    var lastSynchDate = Date()
    var timerPublisher: AnyPublisher<String?, Never>?
    
    private var fetchedResultsController: NSFetchedResultsController<Task_CD>?
    private var previousDate = Date()
    
    private lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var managedContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    


    func setFetchedResultsController() {
        let fetch = NSFetchRequest<Task_CD>(entityName: "Task_CD")
        fetch.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
    }
    
    override init(){//completion: @escaping (([Task_CD]) ->  Void)) {
        super.init()
        setFetchedResultsController()
        fetchData()
        timerPublisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
            .autoconnect()
            .map { [weak self] _ in self?.getTime() }
            .eraseToAnyPublisher()
    }
    
    private func fetchData() {
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Error fetching products")
        }
    }
        
    private func getTime() -> String {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: lastSynchDate, to: Date())
        let hours = String(diffComponents.hour ?? 0)
        let minutes = String(diffComponents.minute ?? 0)
        let seconds = String(diffComponents.second ?? 0)
        
        return String(hours) + String(minutes) + String(seconds)
    }
    
}

extension CoreDataManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let tasks = fetchedResultsController?.fetchedObjects ?? []
        self.completion?(tasks)
        lastSynchDate = Date()
    }
    
}

extension CoreDataManager {
    
    func saveTaskTest(task: Task) {
        let task_cd = Task_CD(context: managedContext)
        task_cd.name = task.name
        task_cd.taskDescription = task.description
        saveContext()
    }
    
    func deleteAllTasks() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task_CD")

        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false

        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                managedContext.delete(item)
            }

            // Save Changes
            try managedContext.save()

        } catch {
            // Error Handling
            // ...
        }
    }
    
}