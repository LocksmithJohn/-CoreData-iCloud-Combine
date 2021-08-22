//
//  TaskScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI
import UIKit

protocol MyView: View {
    var type: SType { get set }
}

struct TasksScreen: MyView {
    
    var type = SType.tasks
    
//    @EnvironmentObject var router: Router
    @EnvironmentObject var container: Container
    
    @State private var tasksNames: [String] = []
    @State private var newTask: String = ""
    @State private var date: String = ""
    
    private var bag = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            Text(date).padding()
            List {
                ForEach(tasksNames, id: \.self) { task in
                    Text(task)
                }
            }
            TextField("new task", text: $newTask)
                .textFieldStyle(CustomTextfieldStyle())
            Button {
                let task = Task(name: newTask, description: "subtitle", parentProject: "nil")
                container.taskInteractor.add(task: task)
            } label: {
                Text("Add Task")
            }.buttonStyle(CustomButtonStyle(color: .green))
            Button { container.taskInteractor.deleteTasks() } label: {
                
                Text("Delete All")
            }
            .buttonStyle(CustomButtonStyle())
            .padding(.bottom, 16)
        }
        .modifier(NavigationBarModifier(type.title))
        .onReceive(tasksPublisher, perform: { tasksNames = $0.map { $0.name ?? "-" } } )
        .onReceive(datePublisher, perform: { date = $0 })
    }
    
    private var tasksPublisher: AnyPublisher<[Task], Never> {
        container.appState.tasksSubject
            .eraseToAnyPublisher()
    }
    
    private var datePublisher: AnyPublisher<String, Never> {
        container.appState.syncTimeSubject
            .eraseToAnyPublisher()
    }
    
}

