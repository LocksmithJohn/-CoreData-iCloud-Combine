//
//  IOS_TaskDetailsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct IOS_TaskDetailsScreen: IOSScreen {
    var type = IOS_SType.taskDetails

    @State private var taskName: String = ""
    @State private var taskDescription: String = ""

    private let appState: TasksAppStateProtocol
    private let interactor: TasksInteractorProtocol?
    private let router: IOS_Router
    private let placeholder = "Task name..."

    init(interactor: InteractorProtocol,
         appState: TasksAppStateProtocol,
         type: IOS_SType,
         router: IOS_Router) {
        self.interactor = interactor as? TasksInteractorProtocol
        self.appState = appState
        self.router = router
        self.type = type
    }

    var body: some View {
        VStack {
            TextField(taskName, text: $taskName) {
                saveAction()
            }.padding()
            TextField(taskDescription, text: $taskDescription) {
                saveAction()
            }.padding()
            Spacer()
            buttonBar
        }
        .modifier(NavigationBarModifier(type.title,
                                        leftImageView: AnyView(leftImage),
                                        leftButtonAction: { router.pop() },
                                        identifier: .screenTitleTaskDetails))
        .background(Color.backgroundMain.ignoresSafeArea())
        .onAppear { fillInitialData() }
    }

    private var leftImage: some View {
        Image(systemName: "arrowshape.turn.up.backward")
            .foregroundColor(Color.taskColor)
    }

    private func saveAction() {
        actions {
            interactor?.add(name: taskName, description: taskDescription)
        } editing: {
            interactor?.editCurrentTask(name: taskName, type: nil)
        }

    }

    private var titleView: some View {
        HStack(spacing: 0) {
            FirstResponderTextView(text: $taskName) {
                saveAction()
            }
            .background(Color.orange)

//            IOS_CheckboxView(tapAction: {},
//                             checkboxSize: .big)
//            TextFieldBig(inputText: $taskName, placeholder: placeholder)
            Spacer()
            buttonBar
        }
        .padding(.leading, 8)
    }

    private func actions(creating: (() -> Void)? = nil,
                         editing: (() -> Void)? = nil) {
        switch type {
        case .taskDetails:
            editing?()
        case .taskCreate:
            creating?()
        default:
            break
        }
    }

    @ViewBuilder private var buttonBar: some View {
        if type == .taskDetails {
            Button {
                interactor?.deleteCurrentTask()
                router.pop()
            } label: { Text("Delete") }
            .buttonStyle(FilledButtonStyle(color: Color.taskColor))
        }
    }

    private func fillInitialData() {
        actions(editing:  {
            guard let existingTask = appState.getCurrentTask() else { return }
            taskName = existingTask.name
            taskDescription = existingTask.description ?? "tutaj"
        })
    }
}
