//
//  IOS_TasksScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI
import UIKit

struct IOS_TasksScreen: IOSScreen {
    
    var type = IOS_SType.tasks
    
    @StateObject private var keyboard: KeyboardResponder = KeyboardResponder()
    
    @State private var newTaskName: String = ""
    @State private var isPopupVisible = false
    @State private var tasks: [Task] = []
    @State private var date: String?
    
    private let appState: TasksAppStateProtocol
    private let tasksInteractor: TasksInteractorProtocol?
    private let router: IOS_Router
    
    init(appState: TasksAppStateProtocol,
         interactor: InteractorProtocol,
         router: IOS_Router) {
        self.tasksInteractor = interactor as? TasksInteractorProtocol
        self.appState = appState
        self.router = router
    }
    
    var body: some View {
            VStack {
                ZStack {
                HStack {
                    Spacer()
                    Button { tasksInteractor?.deleteTasks() } label: {
                        Text("Delete All")
                    }
                    .frame(width: 100)
                    .buttonStyle(BorderedButtonStyle(color: .taskColor))
                }
                List {
                    ForEach(tasks, id: \.self) { task in
                        Text(task.name)
                            .onTapGesture {
                                tasksInteractor?.setCurrentTask(id: task.id)
                                router.route(from: type)
                            }
                            .background(Color.orange)
                            .padding()
                        
                        
                    }
                }
                AboveKeyboardView(isExpanded: $isPopupVisible,
                                  taskname: $newTaskName,
                                  action: keyboard.dismiss)
                }
        }
            .modifier(NavigationBarModifier(type.title,
                                            syncDate: $date,
                                            mainColor: .taskColor,
                                            accessibilityIdentifier: Identifier.screenTitleTasks))
        .onReceive(tasksPublisher, perform: { tasks = $0 })
        .onReceive(datePublisher, perform: { date = $0 })
        .onReceive(keyboard.$isVisible, perform: {
            isPopupVisible = $0
            saveOnRespond()
        })
}
    
    private func saveOnRespond() {
        if !newTaskName.isEmpty && !isPopupVisible {
            let task = Task(id: UUID(), name: newTaskName, description: "subtitle", parentProject: "nil")
            tasksInteractor?.add(task: task)
            newTaskName = ""
        }
    }
    
    private var tasksPublisher: AnyPublisher<[Task], Never> {
        appState.tasksSubject
            .eraseToAnyPublisher()
    }
    
    private var datePublisher: AnyPublisher<String?, Never> {
        appState.syncTimeSubject
            .eraseToAnyPublisher()
    }
    
}

