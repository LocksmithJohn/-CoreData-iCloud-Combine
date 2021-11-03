//
//  MAC_Router.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 05/08/2021.
//

import Combine
import Foundation

class MAC_Router: ObservableObject {
    
    var route = CurrentValueSubject<Route, Never>(.inbox(.creating))
    private var bag = Set<AnyCancellable>()
    
    init() {
        route
            .sink { route in
                print("Route: \(route)")
            }
            .store(in: &bag)
    }
    
}
