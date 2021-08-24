//
//  TaskDetailsScreen_mac.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 05/08/2021.
//

import SwiftUI
import Cocoa

struct TaskDetailsScreen_mac: View {
    
    @EnvironmentObject var container: Container
    @State var taskName: String = ""
    @State var taskDescription: String = ""
    @State var placeholder: String = "Description..."
    
    var type: MiddleType.CanvasTasksType = .initial

    var body: some View {
        VStack {
        if type == .initial {
            Text("Initial")
        } else {
            Text("Details")
        }
            TextField("Provide task name", text: $taskName)
//                .textFieldStyle(.)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(.leading, 16)
            ZStack(alignment: .topLeading) {
                Text(placeholder)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white.opacity(0.3))
                TextEditor(text: $taskDescription)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding()
            .onChange(of: taskDescription) { value in
                if taskDescription.isEmpty {
                    placeholder = "Tutaj opis..."
                } else {
                    placeholder = ""
                }
            }
        MacButton(action: {
            container.tasksInteractor.add(task: Task(name: taskName, description: taskDescription, parentProject: ""))
        }, label: "Create")
                
        }
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
