//
//  InboxScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct InboxScreen: IOSScreen {
    var type = SType.inbox
    
    private let appState: InputsAppState
    private let interactor: InputInteractor
    private let router: IOSRouter
    
    init(interactor: InputInteractor,
         appState: InputsAppState,
         router: IOSRouter) {
        self.interactor = interactor
        self.appState = appState
        self.router = router
    }

    var body: some View {
        VStack {
            Button {
                router.route(from: type)
            } label: {
                Text("Go to Input details")
            }.buttonStyle(CustomButtonStyle())
                .padding(.bottom, 16)
        }
        .modifier(NavigationBarModifier(type.title))
//        .onDisappear { router.hideModal() }
    }
}
