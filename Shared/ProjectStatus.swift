//
//  ProjectStatus.swift
//  Trening_icloud3
//
//  Created by Jan Slusarz on 19/12/2021.
//

import Foundation

public enum ProjectStatus: String, CaseIterable, Identifiable {

    case new
    case inProgress
    case done

    public var id: UUID {
        UUID()
    }

    var name: String {
        switch self {
        case .new:
            return "New"
        case .inProgress:
            return "In progress"
        case .done:
            return "Done"
        }
    }
}
