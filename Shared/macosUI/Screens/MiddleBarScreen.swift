//
//  MiddleBar.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 04/08/2021.
//
import Combine
import SwiftUI

struct MiddleBarScreen: View {
    
    @EnvironmentObject var container: Container
    @EnvironmentObject var router: Router
    
    @State private var tasksNames: [String] = []
    @State private var projectsNames: [String] = []
    @State private var inputsNames: [String] = []
    
    @State private var showingAlert = false

    var body: some View {
        VStack {
            topView
            listView
            bottomView
                .padding()
        }
        .onReceive(tasksPublisher, perform: { tasksNames = $0.map { $0.name } } )
        .onReceive(projectsPublisher, perform: { projectsNames = $0.map { $0.name } } )
        .onReceive(inputsPublisher, perform: { inputsNames = $0.map { $0.name } } )
    }
    
    private var topView: some View {
        Text(String(router.type.title ?? "-"))
    }
    
    @ViewBuilder private var listView: some View {
        switch router.type {
        case .tasks:
            TasksList(tasksNames: $tasksNames)
                .environmentObject(container)
        case .projects:
            ProjectsList(projectsNames: $projectsNames)
        default:
            InputsList(inputsNames: $inputsNames)
        }
    }
    
    private var bottomView: some View {
            return HStack {
                switch router.type {
                case .tasks:
                    HStack {
                    MacButton(action: {
                        router.type = .tasks(.initial) // tutaj scentralizować to
                    }, label: "Add Task")
                    MacButton(action: {
                        container.taskInteractor.deleteTasks()
                    }, label: "Delete All")
                    }

                case .projects:
                    MacButton(action: {
                        router.type = .projects(.details)
                    }, label: "Add Project")
                default:
                    MacButton(action: {
                        container.inputsInteractor.add(input: Input(name: "inoput", description: "asdf"))
                    }, label: "Add Input")

            }
        }
    }
    
    private var tasksPublisher: AnyPublisher<[Task], Never> {
        container.appState.tasksSubject
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
    
}
