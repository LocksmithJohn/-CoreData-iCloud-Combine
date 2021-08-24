//
//  ProjectsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI

struct ProjectsScreen: IOSScreen {
    
    var type = SType.projects
        
    @State private var projectsNames = [String]()
    
    private let appState: ProjectsAppState
    private let interactor: ProjectsInteractor
    private let router: IOSRouter
    
    init(interactor: ProjectsInteractor,
         appState: ProjectsAppState,
         router: IOSRouter) {
        self.interactor = interactor
        self.appState = appState
        self.router = router
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(projectsNames, id: \.self) { task in
                    Text(task)
                }
            }
            Button(action: {
                    interactor.add(project: Project(name: "project", description: "project desc", tasks: [Task(name: "task in project", parentProject: "")]) )
                
            },
                   label: { Text("Add project") } )
                .buttonStyle(CustomButtonStyle(color: .green))
            Button(action: { router.route(from: type) },
                   label: { Text("Project details") } )
                .buttonStyle(CustomButtonStyle())
                .padding(.bottom, 16)
        }
        .modifier(NavigationBarModifier(type.title))
        .onReceive(projectsPublisher) { projectsNames = $0.map { $0.name ?? "-" } }
    }
    
    private var projectsPublisher: AnyPublisher<[Project], Never> {
        appState.projectsSubject.eraseToAnyPublisher()
    }
}

