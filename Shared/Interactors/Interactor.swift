//
//  Interactor.swift
//  Trening_icloud3
//
//  Created by Jan Slusarz on 10/09/2021.
//

import Foundation

protocol InteractorProtocol {}

final class Interactor: InteractorProtocol {
    
    let appState: AppState
    let coreDataManager: CoreDataManager
    
    init(appState: AppState,
        coreDataManager: CoreDataManager) {
        self.appState = appState
        self.coreDataManager = coreDataManager
    }
    
}
