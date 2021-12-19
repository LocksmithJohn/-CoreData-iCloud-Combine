//
//  StateTypes.swift
//  Trening_icloud3
//
//  Created by Jan Slusarz on 26/11/2021.
//

import Foundation

enum TaskType: Int {
    case task
    case nextAction
    case waitingFor

    var name: String? {
        switch self {
        case .task: return "task"
        case .nextAction: return "nextAction"
        case .waitingFor: return "waitingFor"
        }
    }
}
