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

    let projectsSubject = CurrentValueSubject<[Project_CD], CoreDataError>([])
    let tasksSubject = CurrentValueSubject<[Task_CD], CoreDataError>([])
    let syncTimeSubject = PassthroughSubject<String?, Never>()
    
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
                print("filterr      error 3")
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
                print("filterr      error 2")
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
        setFetchedResultsController(entityType: .project)
        setFetchedResultsController(entityType: .task)
        dateManager.startSyncTimer()
        bindSyncTimer()
        getInitialData()
        fetch()
    }
    
    func fetch() {
        do {
            try controllers.first?.performFetch()
        } catch {
            fatalError()
        }
        do {
            try controllers.last?.performFetch()
        } catch {
            fatalError()
        }
    }
    
    private func bindSyncTimer() {
        dateManager.timerPublisher?
            .sink(receiveValue: { [weak self] timeValue in
                self?.syncTimeSubject.send(timeValue)
            })
            .store(in: &cancellableBag)
    }
    
    private func getInitialData() {
        if let projects = getItems(entityType: .project) as? [Project_CD] {
            projectsSubject.send(projects)
        }
        if let tasks = getItems(entityType: .task) as? [Task_CD] {
            tasksSubject.send(tasks)
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
                print("filterr      CoreDataManager:  projectsSubject.send")

                projectsSubject.send(completion: .failure(.fetchEntity(type: .project)))
                return
            }
            projectsSubject.send(projects)
        case String(describing: Task_CD.self):
            guard let tasks = controller.fetchedObjects,
                  let tasks = tasks as? [Task_CD] else {
                print("filterr      CoreDataManager:  tasksSubject.send")

                tasksSubject.send(completion: .failure(.fetchEntity(type: .task)))
                return
            }
            tasksSubject.send(tasks)
        default:
            print("filterr      error 4")
            return
        }
        print("filterr      CoreDataManager:  dateManager.updateDate()")
        dateManager.updateDate()
    }
    
}
