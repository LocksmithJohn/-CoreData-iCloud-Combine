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
    @State private var filteredTasks: [Task] = []
    @State private var date: String?
    @State private var selectionTag: Int = 0

    private let appState: TasksAppStateProtocol
    private let interactor: TasksInteractorProtocol?
    private let router: IOS_Router
    
    init(appState: TasksAppStateProtocol,
         interactor: InteractorProtocol,
         router: IOS_Router) {
        self.interactor = interactor as? TasksInteractorProtocol
        self.appState = appState
        self.router = router
    }
    
    var body: some View {
        VStack {
            pickerView
                .padding(.horizontal)
            scrollView
                .padding(.horizontal)
            AboveKeyboardView(isExpanded: $isPopupVisible,
                              taskname: $newTaskName,
                              action: keyboard.dismiss)
        }
        .modifier(NavigationBarModifier(type.title,
                                        syncDate: $date,
                                        mainColor: .taskColor,
                                        identifier: .screenTitleTasks))
        .onReceive(tasksPublisher, perform: {
            updateTasks(tasks: $0)
            filterTasks()
        })
        .onReceive(datePublisher, perform: { date = $0 })
        .onReceive(keyboard.$isVisible, perform: {
            isPopupVisible = $0
            saveNewTask()
        })
        .onChange(of: selectionTag, perform: { _ in filterTasks() })
        .background(Color.backgroundMain.ignoresSafeArea())
    }

    private var scrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(filteredTasks, id: \.self) { task in
                    IOS_TaskRow(
                        taskName: task.name,
                        tapRowAction: {
                            interactor?.setCurrentTask(id: task.id)
                            router.route(from: type)
                        },
                        checkboxAction: {})
                }
            }
        }
    }

    private var pickerView: some View {
        Picker("Add", selection: $selectionTag) {
            Text("Task").tag(0)
            Text("Next action").tag(1)
            Text("Waiting for").tag(2)
        }
        .pickerStyle(.segmented)
        .frame(height: 60)
        .background(Color.backgroundMain)
    }

    private var testDeleteButton: some View {
        HStack {
            Spacer()
            Button { interactor?.deleteTasks() } label: {
                Text("Delete All")
            }
            .frame(width: 100)
        }
    }

    private func updateTasks(tasks: [Task]) {
        self.tasks = tasks
    }

    private func filterTasks() {
        filteredTasks = tasks.filter {
            var type: TaskType {
                switch selectionTag {
                case 0: return .task
                case 1: return .nextAction
                default: return .waitingFor
                }
            }
            return $0.taskType == type.name
        }
    }
    
    private func saveNewTask() {
        if !newTaskName.isEmpty && !isPopupVisible {
            interactor?.add(name: newTaskName, description: "description")
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

