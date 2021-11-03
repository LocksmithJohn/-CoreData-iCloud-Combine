//
//  ProjectsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI

struct IOS_ProjectsScreen: IOSScreen {
    
    var type = IOS_SType.projects
    
//    @StateObject private var keyboard: KeyboardResponder = KeyboardResponder()
    
    @State private var projects = [Project]()
    @State private var newProjectName: String = "Nazwa mojego Projektu"
    @State private var newProjectDescription: String = "Opis mojego pierwszego Projektu"
    @State private var isPopupVisible = false
    
    private let appState: ProjectsAppStateProtocol
    private let projectsInteractor: ProjectsInteractorProtocol?
    private let router: IOS_Router
    
    init(interactor: InteractorProtocol, // tutaj podmienic na protokol
         appState: ProjectsAppStateProtocol,
         router: IOS_Router) {
        self.projectsInteractor = interactor as? ProjectsInteractorProtocol
        self.appState = appState
        self.router = router
        //        interactor.reloadProjects()
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(projects, id: \.self) { project in
                    Group {
                        IOS_ProjectRow(projectsInteractor: projectsInteractor,
                                       project: project)
                    }
                    .onTapGesture {
                        projectsInteractor?.setCurrentProject(id: project.id)
                        router.route(from: type, strategy: .second)
                    }
                }
            }
            HStack {
                Button(action: { projectsInteractor?.deleteAll() },
                       label: { Text("Delete all") } )
                    .buttonStyle(BorderedButtonStyle(color: .projectColor))
                Button(action: {
                        router.route(from: type, strategy: .first)},
                       label: { Text("Add project") })
                    .buttonStyle(FilledButtonStyle(color: .projectColor))
            }
        }
        .padding()
        .modifier(NavigationBarModifier(type.title, mainColor: .projectColor))
        .onReceive(projectsPublisher) {
            projects = $0
        }
    }

    private var projectsPublisher: AnyPublisher<[Project], Never> {
        appState.projectsSubject.eraseToAnyPublisher()
    }
    
    private var datePublisher: AnyPublisher<String?, Never> {
        appState.syncTimeSubject.eraseToAnyPublisher()
    }
    
}
