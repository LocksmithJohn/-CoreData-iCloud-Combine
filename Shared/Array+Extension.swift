//
//  Array+Extension.swift
//  Trening_icloud3
//
//  Created by User on 24/08/2021.
//

import CoreData
import Foundation

extension Array where Element == NSFetchedResultsController<NSFetchRequestResult> {
    
    func getFor(type: EntityType) -> Element? {
        first { controller in
            controller.fetchRequest.entity?.name == String(describing: type.type.self)
        }
    }
    
}
