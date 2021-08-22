//
//  Light_Navigation_Architecture_on_MacApp.swift
//  Shared
//
//  Created by User on 03/08/2021.
//

import SwiftUI

@main
struct Light_Navigation_Architecture_on_MacApp: App {
    
    let container = Container()
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: container)
                .ignoresSafeArea()
        }
    }
}
