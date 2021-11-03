//
//  TaskDetailsScreen_mac.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 05/08/2021.
//

import Combine
import SwiftUI
import Cocoa

struct MAC_TaskDetailsScreen: View {
    
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var placeholder: String = "Description..."
    @State private var route: Route = .tasks(.creating)
    
    private let appState: TasksAppStateProtocol
    private let router: MAC_Router
    private let interactor: TasksInteractorProtocol?
    
    init(appState: TasksAppStateProtocol,
         router: MAC_Router,
         interactor: TasksInteractorProtocol?) {
        self.appState = appState
        self.router = router
        self.interactor = interactor
        fillInData()
    }
    
    var body: some View {
        VStack {
            TextField("Task name...", text: $taskName)
                                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
//            ZStack(alignment: .topLeading) {
//                Text(placeholder)
//                    .font(.system(size: 20, weight: .bold, design: .rounded))
//                    .foregroundColor(.white.opacity(0.3))
//                TextEditor(text: $taskDescription)
//                    .font(.system(size: 20, weight: .bold, design: .rounded))
//                    .foregroundColor(.white)
//                    .lineLimit(1)
//            }
            .padding()
            .onChange(of: taskDescription) { value in
                if taskDescription.isEmpty {
                    placeholder = "Tutaj opis..."
                } else {
                    placeholder = ""
                }
            }
            buttonsBar
        }
        .onReceive(routePublisher, perform: {
            route = $0
            fillInData()
        })
    }
    
    private var buttonsBar: some View {
        HStack(spacing: 16) {
            MAC_Button(action: { saveAction() }, label: "Save")
            if case .tasks(.editing) = route {
                MAC_Button(action: { deleteAction() }, label: "Delete")
            }
        }
        .padding()
    }
    
    private var routePublisher: AnyPublisher<Route, Never> {
        router.route.eraseToAnyPublisher()
    }
    
    private func fillInData() {
        switch route {
        case .tasks(.editing):
            if let existingTask = appState.getCurrentTask() {
                taskName = existingTask.name
                taskDescription = existingTask.description ?? ""
            }
        default:
            taskName = ""
            taskDescription = ""
        }
    }
    
    private func saveAction() {
        switch route {
        case .tasks(.editing):
            if let id = appState.currentTaskID {
                let newTask = Task(id: id,
                                   name: taskName,
                                   description: taskDescription,
                                   parentProject: "")
                interactor?.edit(id: newTask.id, newTask: newTask)
            }
        default:
            let newTask = Task(id: UUID(),
                               name: taskName,
                               description: taskDescription,
                               parentProject: "")
            interactor?.add(task: newTask)
        }
    }
    
    private func deleteAction() {
        interactor?.deleteCurrentTask()
    }
    
}

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
        }
    }
}
