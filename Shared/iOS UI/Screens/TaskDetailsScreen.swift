//
//  TaskDetailsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct TaskDetailsScreen: IOSScreen {
    var type = SType.taskDetails
    
    @EnvironmentObject var container: Container

    var body: some View {
        VStack {
            Text("Hello world!")
        }.modifier(NavigationBarModifier(type.title,
                                         leftButtonImage: Image(systemName: "arrowshape.turn.up.backward"),
                                         leftButtonAction: { container.routerTasks.pop() }))
    }
}

struct TaskDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsScreen()
    }
}

