//
//  Trening_icloud3App.swift
//  Shared
//
//  Created by User on 15/08/2021.
//

import SwiftUI

@main
struct Trening_icloud3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
