//
//  TaskScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI
import UIKit

struct TasksScreen: IOSScreen {
    
    var type = SType.tasks
    
    @State private var tasksNames: [String] = []
    @State private var newTask: String = ""
    @State private var date: String?
    
    private var bag = Set<AnyCancellable>()
    private let appState: TasksAppState
    private let interactor: TasksInteractor
    private let router: IOSRouter
    
    init(interactor: TasksInteractor,
         appState: TasksAppState,
         router: IOSRouter) {
        self.interactor = interactor
        self.appState = appState
        self.router = router
    }
    
    var body: some View {
        VStack {
            if let date = date {
                Text(date).padding()
            }
            List {
                ForEach(tasksNames, id: \.self) { task in
                    Text(task)
                }
            }
            TextField("new task", text: $newTask)
                .textFieldStyle(CustomTextfieldStyle())
            Button {
                let task = Task(name: newTask, description: "subtitle", parentProject: "nil")
                interactor.add(task: task)
            } label: {
                Text("Add Task")
            }.buttonStyle(CustomButtonStyle(color: .green))
            Button { interactor.deleteTasks() } label: {
                
                Text("Delete All")
            }
            .buttonStyle(CustomButtonStyle())
            .padding(.bottom, 16)
        }
        .modifier(NavigationBarModifier(type.title))
        .onReceive(tasksPublisher, perform: { tasksNames = $0.map { $0.name } } )
        .onReceive(datePublisher, perform: { date = $0 })
    }
    
    private var tasksPublisher: AnyPublisher<[Task], Never> {
        appState.tasksSubject
            .eraseToAnyPublisher()
    }

    private var datePublisher: MyAnyPublisher<String?> {
        appState.syncTimeSubject
            .eraseToAnyPublisher()
    }
    
}

