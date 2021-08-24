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

    let projectsSubject = PassthroughSubject<[Project_CD], CoreDataError>()
    let tasksSubject = PassthroughSubject<[Task_CD], CoreDataError>()
    let syncTimeSubject = MyPassthroughSubject<String?>()
    
    var managedContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    private let dateManager: DateManager
    private var controllers: [NSFetchedResultsController<NSFetchRequestResult>] = []
    private var cancellableBag = Set<AnyCancellable>()

    private lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func setFetchedResultsController(entityType: EntityType) {
        let className = String(describing: entityType.type.self)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: className)
        fetch.sortDescriptors = [NSSortDescriptor(key: entityType.mainAttributeName, ascending: true)]
        let resultsController = NSFetchedResultsController(fetchRequest: fetch,
                                                           managedObjectContext: managedContext,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
        resultsController.delegate = self
        controllers.append(resultsController)
    }

    init(dateManager: DateManager) {
        self.dateManager = dateManager
        super.init()
        setFetchedResultsController(entityType: .task)
        setFetchedResultsController(entityType: .project)
        fetchData(entityType: .task)
        fetchData(entityType: .project)
        dateManager.startSyncTimer()
        bindSyncTimer()
    }
    
    private func bindSyncTimer() {
        dateManager.timerPublisher?
            .sink(receiveValue: { [weak self] timeValue in
                self?.syncTimeSubject.send(timeValue)
            })
            .store(in: &cancellableBag)
    }
    
    private func fetchData(entityType: EntityType) {
        do {
            try controllers.getFor(type: entityType)?.performFetch()
        } catch {
            print("Error fetching products") // tutaj obsluga errorow
        }
    }
    
}

enum CoreDataError: Error {
    case fetchEntity(type: EntityType)
}

extension CoreDataManager: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        switch controller.fetchRequest.entity?.name {
        case String(describing: Project_CD.self):
            guard let projects = controller.fetchedObjects,
                  let projects = projects as? [Project_CD] else {
                projectsSubject.send(completion: .failure(.fetchEntity(type: .project)))
                return
            }
            projectsSubject.send(projects)
        case String(describing: Task_CD.self):
            guard let tasks = controller.fetchedObjects,
                  let tasks = tasks as? [Task_CD] else {
                tasksSubject.send(completion: .failure(.fetchEntity(type: .task)))
                return
            }
            tasksSubject.send(tasks)
        default:
            return
        }
        
        dateManager.updateDate()
    }
    
}
