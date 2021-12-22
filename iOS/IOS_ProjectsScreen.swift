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
        .modifier(NavigationBarModifier(type.title,
                                        rightImageView: AnyView(rightImage),
                                        rightButtonAction: { plusButtonAction() },
                                        mainColor: .projectColor,
                                        identifier: .screenTitleProjects))
        .onReceive(projectsPublisher) { projects = $0 }
        .background(Color.backgroundMain.ignoresSafeArea())
    }

    private var scrollView: some View {
        ScrollView {
            ForEach(projects, id: \.self) { project in
                IOS_ProjectRow(projectName: project.name,
                               projectStatus: project.status)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    .onTapGesture {
                        projectsInteractor?.setCurrentProject(id: project.id)
                        router.route(from: type, strategy: .second)
                    }
            }
        }
    }

    private var rightImage: some View {
        Image.plus.with(.small, .projectColor)
    }

    private var buttons: some View {
        HStack {
            Button {
                projectsInteractor?.deleteAll()
            } label: {
                Image.trash.with(.medium)
                    .frame(width: 80, height: 80)
            }
            Spacer()
        }
    }

    private func plusButtonAction() {
        router.route(from: type, strategy: .first)
    }

    private var projectsPublisher: AnyPublisher<[Project], Never> {
        appState.projectsSubject.eraseToAnyPublisher()
    }
    
    private var datePublisher: AnyPublisher<String?, Never> {
        appState.syncTimeSubject.eraseToAnyPublisher()
    }
    
}
