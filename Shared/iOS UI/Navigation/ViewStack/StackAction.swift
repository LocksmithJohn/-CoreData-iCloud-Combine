//
//  StackActoin.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Foundation

enum StackAction {
    case set([SType])
    case push(SType)
    case pushExisting(SType)
    case pop
    case dismiss
    case present(SType)
}
