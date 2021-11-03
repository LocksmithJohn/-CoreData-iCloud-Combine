//
//  ProjectDetailsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct IOS_ProjectDetailsScreen: IOSScreen {
    
    @State private var projectName: String = ""
    @State private var projectDescription: String = ""
    @State private var tasks: [Task] = []
    @State private var addingTaskName: String = ""
    
    var type: IOS_SType
    
    private let appState: ProjectsAppStateProtocol
    private let projectsInteractor: ProjectsInteractorProtocol?
    private let router: IOS_Router
    private let placeholder = "Project name..."
    
    init(interactor: InteractorProtocol,
         appState: ProjectsAppStateProtocol,
         type: IOS_SType,
         router: IOS_Router) {
        self.projectsInteractor = interactor as? ProjectsInteractorProtocol
        self.appState = appState
        self.type = type
        self.router = router
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text("•")
                        .font(.system(size: 30))
                        .padding(.leading, 16)
                        .foregroundColor(.projectColor)
                    TextFieldBig(inputText: $projectName, placeholder: placeholder)
                }
                TextEditorDefault(inputText: $projectDescription)
                    .frame(height: 60)
                VStack {
                    tasksList
                    addTaskView
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                Spacer()
                buttonBar
                
                if #available(iOS 15.0, *) {
                    VStack {
                        HStack(spacing: 8) {
                            Image(systemName: "tray.and.arrow.down")
                            Text("Inbox")
                            Spacer()
                        }
                        .padding(.leading, 24)
                        .frame(height: 40)
                        .background(Color.orange)
                        TextField("type here", text: .constant("asdaf"))
                        Spacer()
                        HStack(spacing: 8) {

                            Spacer()
                        }
                        .frame(height: 40)

                        .background(Color.orange)
                    }
//                    .padding()
//                    .frame(width: 300, height: 300)
                    .cornerRadius(20)
                    .background(.regularMaterial)
                    .cornerRadius(20)
                } else {
                    Text("not ios 15")
                }
            }
        }
        .padding()
        .modifier(NavigationBarModifier(type.title,
                                        leftButtonImage: Image(systemName: "arrowshape.turn.up.backward"),
                                        leftButtonAction: { router.pop() },
                                        mainColor: .projectColor,
                                        accessibilityIdentifier: Identifier.screenTitleProjectDetails))
        .onAppear { fillInData() }
    }
    
    private var addTaskView: some View {
        HStack {
            TextFieldSmall(inputText: $addingTaskName, placeholder: "Add task")
            Button(action: {
                let task = Task(id: UUID(), name: addingTaskName, description: "-", parentProject: "|")
                tasks.append(task)
                addingTaskName = ""
            }, label: {
                Image(systemName: "plus.square")
                    .font(.system(size: 28))
                    .foregroundColor(.projectColor)
                    .padding()
            })
        }
    }
    
    private var tasksList: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(tasks) { task in
                    HStack(alignment: .center) {
                        Text("•")
                            .font(.system(size: 30))
                            .padding(.leading, 16)
                            .foregroundColor(.taskColor)
                        Text(task.name).padding()
                        Spacer()
                    }
                    .padding(.leading, 16)
                }
            }
        }
    }
    
    private var buttonBar: some View {
        HStack {
            Button {
                saveAction()
                router.pop()
            } label: { Text("Save") }
            .buttonStyle(FilledButtonStyle(color: Color.projectColor))
            Button {
                projectsInteractor?.deleteCurrentProject()
                router.pop()
            } label: { Text("Delete") }
            .buttonStyle(BorderedButtonStyle(color: Color.projectColor))
        }
    }
    
    private func saveAction() {
        actions {
            projectsInteractor?.add(newName: projectName,
                           newDescription: projectDescription,
                           newTasks: tasks)
        } editing: {
            projectsInteractor?.editProject(newName: projectName,
                                   newDescription: projectDescription,
                                   newTasks: tasks)
        }
        
    }
    
    private func fillInData() {
        actions(editing:  {
            if let existingProject = appState.getCurrentProject() {
                projectName = existingProject.name
                projectDescription = existingProject.description ?? ""
                tasks = existingProject.tasks
            }
        })
    }
    
    private func actions(creating: (() -> Void)? = nil,
                         editing: (() -> Void)? = nil) {
        switch type {
        case .projectDetails:
            editing?()
        case .projectCreate:
            creating?()
        default:
            break
        }
    }
    
}
