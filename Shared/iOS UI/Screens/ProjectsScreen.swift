//
//  ProjectsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI

struct ProjectsScreen: MyView {
    var type = SType.projects
    
    @EnvironmentObject var container: Container
    
    @State var projectsNames = [String]()
    
    var body: some View {
        VStack {
            List {
                ForEach(projectsNames, id: \.self) { task in
                    Text(task)
                }
            }
            Button(action: { container.projectsInteractor.add(project: Project(name: "project", description: "project desc", tasks: [Task(name: "task in project", parentProject: "")]) ) },
                   label: { Text("Add project") } )
                .buttonStyle(CustomButtonStyle(color: .green))
            Button(action: { container.routerProjects.route(from: type) },
                   label: { Text("Project details") } )
                .buttonStyle(CustomButtonStyle())
                .padding(.bottom, 16)
        }
        .modifier(NavigationBarModifier(type.title))
        .onReceive(projectsPublisher) { projectsNames = $0.map { $0.name ?? "-" } }
    }
    
    private var projectsPublisher: AnyPublisher<[Project], Never> {
        container.appState.projectsSubject
            .eraseToAnyPublisher()
    }
}

