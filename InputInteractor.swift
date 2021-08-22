//
//  InputInteractor.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 04/08/2021.
//

import Foundation

protocol InputInteractorProtocol {
    func add(input: Input)
}

class InputInteractor: InputInteractorProtocol {

    var appState: AppState

    init(appstate: AppState) {
        self.appState = appstate
    }

    func add(input: Input) {
        appState.addInput(input)
    }

}
