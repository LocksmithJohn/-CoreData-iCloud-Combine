//
//  InboxScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct IOS_InboxScreen: IOSScreen {
    var type = IOS_SType.inbox
    
    private let appState: InputsAppStateProtocol
    private let inputInteractor: InputInteractorProtocol?
    private let router: IOS_Router
    
    init(interactor: InteractorProtocol,
         appState: InputsAppStateProtocol,
         router: IOS_Router) {
        self.inputInteractor = interactor as? InputInteractorProtocol
        self.appState = appState
        self.router = router
    }
    
    var body: some View {
        VStack {
            Button {
                router.route(from: type)
            } label: {
                Text("Go to Input details")
            }.buttonStyle(FilledButtonStyle(color: .yellow))
            .padding()
        }
        .modifier(NavigationBarModifier(type.title, mainColor: .inboxColor))
    }
}
