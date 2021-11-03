//
//  Container.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI

class Container: ObservableObject {
    
    let dateManager = DateManager()
    let appState: AppState
    let coreDataManager: CoreDataManager
    let interactor: InteractorProtocol
    
    private var bag = Set<AnyCancellable>()

#if os(iOS)
    @Published var routerInbox = IOS_Router()
    @Published var routerTasks = IOS_Router()
    @Published var routerProjects = IOS_Router()
#elseif os(macOS)
    let router = MAC_Router()
#endif
    
    init() {
        self.coreDataManager = CoreDataManager(dateManager: dateManager)
        self.appState = AppState(coreDataManager: coreDataManager)
        self.interactor = Interactor(appState: appState, coreDataManager: coreDataManager)
//        let asdf = \AppState.errors
        bindRouters()
    }
    
    private func bindRouters() {
        #if os(iOS)
        Publishers.Merge3(routerTasks.$screens,
                          routerProjects.$screens,
                          routerInbox.$screens)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &bag)
        #endif
    }
    
}
