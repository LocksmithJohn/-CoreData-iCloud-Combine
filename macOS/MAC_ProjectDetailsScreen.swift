//
//  MAC_ProjectDetailsScreen.swift
//  Trening_icloud3
//
//  Created by User on 05/09/2021.
//

import Combine
import SwiftUI

struct MAC_ProjectDetailsScreen: View {
    
    @StateObject var viewModel = MAC_ProjectDetailsScreenViewModel()
    
    @State private var projectName: String = ""
    @State private var projectDescription: String = ""

    @State private var route: Route = .projects(.creating)
    @State private var addingTaskName: String = ""
    
    private var bags = Set<AnyCancellable>()
    private let appState: ProjectsAppStateProtocol
    private let router: MAC_Router
    private let projectsInteractor: ProjectsInteractorProtocol?
    
    init(appState: ProjectsAppStateProtocol,
         router: MAC_Router,
         projectsInteractor: ProjectsInteractorProtocol?) {
        self.appState = appState
        self.router = router
        self.projectsInteractor = projectsInteractor
        fillInData()
    }

    var body: some View {
        VStack {
            HStack {
                Text("•")
                    .foregroundColor(.projectColor)
                TextField("Project name...", text: $projectName)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
            }
            .font(.system(size: 30, weight: .bold, design: .rounded))
            tasksList
            buttonsBar
        }
        .onReceive(router.route, perform: { r in // ten onReceive zle dziala
            if r == .projects(.creating) {
                projectName = ""
                projectDescription = ""
                viewModel.tasks.removeAll()
            } else if r == .projects(.editing) {
                if let existingProject = appState.getCurrentProject() {
                    projectName = existingProject.name
                    projectDescription = existingProject.description ?? ""
                    viewModel.tasks = existingProject.tasks
                }
            }
        })
        
    }

    private var addTaskView: some View {
        HStack {
            Button(action: { addTask() },
                   label: { Image(systemName: "plus.square") })
            .buttonStyle(PlainButtonStyle())
            TextEditor(text: $addingTaskName)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
        }
    }
    
    private func addTask() {
        let task = Task(id: UUID(), name: addingTaskName, description: "-", parentProject: "|")
        viewModel.tasks.append(task)
        addingTaskName = ""
    }
    
    private var tasksList: some View {
        VStack {
            Text("Tasks")
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.tasks) { task in
                        HStack(alignment: .center) {
                            Text("•")
                                .font(.system(size: 30))
                                .padding(.leading, 16)
                                .foregroundColor(.taskColor)
                            Text(task.name).padding()
                            Spacer()
                        }
                    }
                    addTaskView
                }
            }
        }
    }
    
    private var buttonsBar: some View {
        HStack {
            Button {
                saveAction()
            } label: { Text("Save") }
            .buttonStyle(FilledButtonStyle(color: Color.projectColor))
            Button {
                projectsInteractor?.deleteCurrentProject()
            } label: { Text("Delete") }
            .buttonStyle(BorderedButtonStyle(color: Color.projectColor))
        }
    }
    
    private func saveAction() {
        actions {
            projectsInteractor?.add(newName: projectName,
                           newDescription: projectDescription,
                           newTasks: viewModel.tasks)
        } editing: {
            projectsInteractor?.editCurrentProject(newName: projectName,
                                   newDescription: projectDescription,
                                   newTasks: viewModel.tasks)
        }
    }
    
    private func actions(creating: (() -> Void)? = nil,
                         editing: (() -> Void)? = nil) {
        switch route {
        case .projects(.editing): editing?()
        case .projects(.creating): creating?()
        default:  break
        }
    }
    
    private func fillInData() {
        actions {
            projectName = ""
            projectDescription = ""
            viewModel.tasks.removeAll()
        } editing: {
            if let existingProject = appState.getCurrentProject() {
                projectName = existingProject.name
                projectDescription = existingProject.description ?? ""
                viewModel.tasks = existingProject.tasks
            }
        }
    }
    
}
