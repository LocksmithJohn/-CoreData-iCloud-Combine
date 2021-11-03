//
//  StackActoin.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Foundation

enum StackAction {
    case set([IOS_SType])
    case push(IOS_SType)
    case pushExisting(IOS_SType)
    case pop
    case dismiss
    case present(IOS_SType)
}
