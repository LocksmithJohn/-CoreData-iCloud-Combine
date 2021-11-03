//
//  MiddleBar.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 04/08/2021.
//
import Combine
import SwiftUI

struct MAC_MiddleBarScreen: View {
        
    @State private var tasks: [Task] = []
    @State private var projects: [Project] = []
    @State private var inputsNames: [String] = []
    @State private var showingAlert = false
    @State private var route: Route = .tasks(.creating)
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }

    var body: some View {
        VStack {
            topView
            listView
//            bottomView
//                .padding()
        }
        .onReceive(tasksPublisher, perform: { tasks = $0 })
        .onReceive(routePublisher, perform: { route = $0 })
        .onReceive(projectsPublisher, perform: { projects = $0 })
        .onReceive(inputsPublisher, perform: { inputsNames = $0.map { $0.name } })
    }
    
    private var topView: some View {
        Text(route.title ?? "-")
    }
    
    @ViewBuilder private var listView: some View {
        switch route {
        case .tasks:
            MAC_TasksList(router: container.router,
                          interactor: container.interactor as? TasksInteractorProtocol,
                          tasks: $tasks)
        case .projects:
            MAC_ProjectsList(router: container.router,
                             interactor: container.interactor as? ProjectsInteractorProtocol,
                             projects: $projects)
        default:
            MAC_InputsList(inputsNames: $inputsNames)
        }
    }
    
//    private var bottomView: some View {
//            return HStack {
//                switch route {
//                case .tasks:
//                        MAC_Button(action: {
//                            container.router.route.send(.tasks(.creating))
//                    }, label: "Add Task")
//                        .padding()
//
//                case .projects:
//                    MAC_Button(action: {
//                        container.interactor.
//                        projectsInteractor.add(newName: "projekt name", newDescription: "projekt opis", newTasks: [])
////                        router.type = .projects(.details)
//                    }, label: "Add Project")
//                default:
//                    MAC_Button(action: {
////                        container.inputsInteractor.add(input: Input(name: "inoput", description: "asdf"))
//                    }, label: "Add Input")
//
//            }
//        }
//    }
    
    private var tasksPublisher: AnyPublisher<[Task], Never> { // tutaj te poniższe mają byc w podwidokach - wywalic stad
        return container.appState.tasksSubject
            .eraseToAnyPublisher()
    }
    
    private var projectsPublisher: AnyPublisher<[Project], Never> {
        container.appState.projectsSubject
            .eraseToAnyPublisher()
    }
    
    private var inputsPublisher: AnyPublisher<[Input], Never> {
        container.appState.inputsSubject
            .eraseToAnyPublisher()
    }
    
    private var routePublisher: AnyPublisher<Route, Never> {
        container.router.route
            .eraseToAnyPublisher()
    }
    
}
