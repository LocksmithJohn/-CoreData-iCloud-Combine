//
//  MAC_TasksList.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 04/08/2021.
//

import SwiftUI

struct MAC_TasksList: View {
    
    @Binding var tasks: [Task]
    
    private let router: MAC_Router
    private let interactor: TasksInteractorProtocol?
    
    init(router: MAC_Router,
         interactor: TasksInteractorProtocol?,
         tasks: Binding<[Task]>) {
        self.router = router
        self.interactor = interactor
        _tasks = tasks
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(tasks, id: \.self) { task in
                    HStack {
                        Text("•")
                            .font(.system(size: 30))
                            .padding(.leading, 16)
                            .foregroundColor(.taskColor)
                        Text(task.name)
                        Spacer()
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onTapGesture {
                        interactor?.setCurrentTask(id: task.id)
                        router.route.send(.tasks(.editing))
                    }
                }
            }
            MAC_Button(action: {
                router.route.send(.tasks(.creating))
            }, label: "Add Task")
            MAC_Button(action: {
                interactor?.deleteTasks()
            }, label: "Delete All")
            .padding()
        }
    }
    
}
