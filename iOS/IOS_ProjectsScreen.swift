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

    @State private var projects = [Project]()
    @State private var newProjectName: String = "Nazwa mojego Projektu"
    @State private var newProjectDescription: String = "Opis mojego pierwszego Projektu"
    @State private var isPopupVisible = false
    
    private let appState: ProjectsAppStateProtocol
    private let projectsInteractor: ProjectsInteractorProtocol?
    private let router: IOS_Router
    
    init(interactor: InteractorProtocol,
         appState: ProjectsAppStateProtocol,
         router: IOS_Router) {
        self.projectsInteractor = interactor as? ProjectsInteractorProtocol
        self.appState = appState
        self.router = router
    }
    
    var body: some View {
        VStack {
            scrollView
            buttons
        }
        .padding()
        .modifier(NavigationBarModifier(type.title,
                                        mainColor: .projectColor,
                                        identifier: .screenTitleProjects))
        .onReceive(projectsPublisher) { projects = $0 }
        .background(Color.backgroundMain.ignoresSafeArea())
    }

    private var scrollView: some View {
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
    }

    private var buttons: some View {
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

    private var projectsPublisher: AnyPublisher<[Project], Never> {
        appState.projectsSubject.eraseToAnyPublisher()
    }
    
    private var datePublisher: AnyPublisher<String?, Never> {
        appState.syncTimeSubject.eraseToAnyPublisher()
    }
    
}
