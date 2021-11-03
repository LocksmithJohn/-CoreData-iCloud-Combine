//
//  InputDetailsScreen_mac.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 05/08/2021.
//

import SwiftUI

struct MAC_InputDetailsScreen: View {
    
    @State private var inputName: String = ""
    @State private var inputDescription: String = ""
    @State private var placeholder: String = "Description..."
    @State private var route: Route = .tasks(.creating)
    
//    private let appState: InputsAppStateProtocol
//    private let router: MAC_Router
//    private let interactor: InputInteractorProtocol
//    
//    init(appState: InputsAppStateProtocol,
//         router: MAC_Router,
//         interactor: InputInteractorProtocol) {
//        self.appState = appState
//        self.router = router
//        self.interactor = interactor
//    }
    
    var body: some View {
        VStack {
            TextField("Task name...", text: $inputName)
                                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
            descriptionTextEditor
            buttonsBar
        }
    }
    
    private var descriptionTextEditor: some View {
        ZStack(alignment: .topLeading) {
            Text(placeholder)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white.opacity(0.3))
            TextEditor(text: $inputDescription)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
        }
    }
    
    private var buttonsBar: some View {
        HStack(spacing: 16) {
            MAC_Button(action: { saveAction() }, label: "Save")
//            if case let .tasks(.editing(id)) = route {
//                MAC_Button(action: { deleteAction(id) }, label: "Delete")
//            }
        }
        .padding()
    }
    
    private func saveAction() {
//        switch route {
//        case let .tasks(.editing(id)):
//            let newTask = Task(id: id,
//                               name: inputName,
//                               description: taskDescription,
//                               parentProject: "")
//            interactor.edit(id: id, newTask: newTask)
//        default:
//            let newTask = Task(id: UUID(),
//                               name: inputName,
//                               description: taskDescription,
//                               parentProject: "")
//            interactor.add(task: newTask)
//        }
    }
    
    private func deleteAction(_ id: UUID) {
//        interactor.deleteTask(id: id)
    }
}
