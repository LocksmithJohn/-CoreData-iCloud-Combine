//
//  EntityType.swift
//  Trening_icloud3
//
//  Created by User on 24/08/2021.
//

import CoreData
import Foundation

public enum EntityType {
    case task
    case project
    
    public var type: NSManagedObject.Type {
        switch self {
        case .task:
            return Task_CD.self
        case .project:
            return Project_CD.self
        }
    }
    
    var mainAttributeName: String {
        switch self {
        case .task,
             .project:
            return "name"
        }
    }
}
