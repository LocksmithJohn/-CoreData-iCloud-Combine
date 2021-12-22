//
//  IOS_NewTaskView.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 11/12/2021.
//

import SwiftUI

struct IOS_NewTaskView: View {

    let projectsInteractor: ProjectsInteractorProtocol?

    @Binding private var isInputMode: Bool
    @State private var taskName: String = ""
    @State private var selectionTag: Int = 0
    @State private var rotationDegrees: Double = 0
    @State private var totalChars = 0
    @State private var lastText = ""
    private let placeholder: String = "What to do...?"
    private var newTask: Task?
    

    init(isInputMode: Binding<Bool>,
         projectsInteractor: ProjectsInteractorProtocol?){
        self.projectsInteractor = projectsInteractor
        _isInputMode = isInputMode
        UIPickerView.appearance().backgroundColor = .backgroundMain
        UISegmentedControl.appearance().backgroundColor = .backgroundMain
        UISegmentedControl.appearance().selectedSegmentTintColor = .backgroundMain
        UITextView.appearance().backgroundColor = .backgroundMain
    }

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: "plus")
                .foregroundColor(.gray)
                .rotationEffect(.degrees(isInputMode ? 45 : 0))
                .onTapGesture { isInputMode.toggle() }
                .padding(.top, 8)
            VStack(spacing: 0) {
                if isInputMode {
                    FirstResponderTextView(text: $taskName) { _ in
                        isInputMode = false
                        addTask()
                    }
                    .background(Color.objectMain)
                    .cornerRadius(10)
                    .frame(height: 36)
                    picker
                } else {
                    emptyView
                }
            }
        }
        .padding(.bottom, 40)
        .padding(.leading, 3)
    }

    private var emptyView: some View {
        HStack {
            Spacer()
        }
        .frame(height: 60)
        .background(Color.backgroundMain)
    }

    private var picker: some View {
        Picker("Add", selection: $selectionTag) {
            Text("Task").tag(0)
            Text("Next action").tag(1)
            Text("Waiting for").tag(2)
        }
        .pickerStyle(.segmented)
        .frame(height: 60)
        .background(Color.backgroundMain)
    }

    private func addTask() {
        var type: TaskType {
            switch selectionTag {
            case 0: return .task
            case 1: return .nextAction
            default: return .waitingFor
            }
        }
        guard !taskName.isEmpty else { return }

        let task = Task(name: taskName,
                        parentProject: "",
                        taskType: type.name)
        projectsInteractor?.addTaskToCurrentProject(task: task)
        taskName = ""
    }
}
