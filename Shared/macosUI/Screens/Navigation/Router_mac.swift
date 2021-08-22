//
//  Router_mac.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 05/08/2021.
//

import Foundation

class Router: ObservableObject {
    
    @Published var type: MiddleType = .tasks(.initial) {
        didSet {
            print("filter type: \(type)")
        }
    }
    
}
