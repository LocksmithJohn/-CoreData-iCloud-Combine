//
//  CanvasView.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 04/08/2021.
//
import Combine
import SwiftUI

struct MAC_CanvasScreen: View {
    
    @State private var route: Route = .tasks(.creating)
    
    private let appState: AppState
//    private let interactor: InteractorProtocol
    private let router: MAC_Router
    
    private let taskInteractor: TasksInteractorProtocol?
    private let projectsInteractor: ProjectsInteractorProtocol?
//    private let inputInteractor: InputInteractorProtocol?


    init(appState: AppState,
         router: MAC_Router,
         interactor: InteractorProtocol) {
        self.appState = appState
        self.router = router
        self.taskInteractor = interactor as? TasksInteractorProtocol
        self.projectsInteractor = interactor as? ProjectsInteractorProtocol
//        self.inputInteractor = interactor as? InputInteractorProtocol
    }

    var body: some View {
        VStack {
            switch route {
            case .tasks:
                MAC_TaskDetailsScreen(appState: appState,
                                      router: router,
                                      interactor: taskInteractor)
            case .projects:
                MAC_ProjectDetailsScreen(appState: appState,
                                         router: router,
                                         projectsInteractor: projectsInteractor)
            case .inbox:
                MAC_InputDetailsScreen()
            }
        }
        .onReceive(routePublisher, perform: { route = $0 } )
    }
    
    private var routePublisher: AnyPublisher<Route, Never> {
        router.route.eraseToAnyPublisher()
    }
    
}
 
