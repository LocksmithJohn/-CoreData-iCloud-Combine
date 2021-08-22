//
//  ProjectDetailsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct ProjectDetailsScreen: MyView {
    
    @EnvironmentObject var container: Container

    var type = SType.projectDetails
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.modifier(NavigationBarModifier(type.title,
                                         leftButtonImage: Image(systemName: "arrowshape.turn.up.backward"),
                                         leftButtonAction: { container.routerProjects.pop() }))
    }
}
