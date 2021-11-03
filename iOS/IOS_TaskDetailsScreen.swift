//
//  IOS_TaskDetailsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct IOS_TaskDetailsScreen: IOSScreen {
    var type = IOS_SType.taskDetails
    
    @EnvironmentObject var container: Container

    var body: some View {
        VStack {
            Spacer()
        }.modifier(NavigationBarModifier(type.title,
                                         leftButtonImage: Image(systemName: "arrowshape.turn.up.backward"),
                                         leftButtonAction: { container.routerTasks.pop() },
                                         accessibilityIdentifier: Identifier.screenTitleTaskDetails))
    }
}
