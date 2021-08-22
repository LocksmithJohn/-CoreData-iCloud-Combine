//
//  InboxScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct InboxScreen: MyView {
    var type = SType.inbox
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var container: Container

    var body: some View {
        VStack {
            Button {
                container.routerInbox.route(from: type)
            } label: {
                Text("Go to Input details")
            }.buttonStyle(CustomButtonStyle())
                .padding(.bottom, 16)
        }
        .modifier(NavigationBarModifier(type.title))
//        .onDisappear { router.hideModal() }
    }
}
