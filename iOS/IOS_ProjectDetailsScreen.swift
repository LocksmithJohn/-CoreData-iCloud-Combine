//
//  ProjectDetailsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Combine
import SwiftUI

struct IOS_ProjectDetailsScreen: IOSScreen {

    var type: IOS_SType

    @State private var projectName: String = ""
    @State private var projectDescription: String = ""
    @State private var projectStatus: ProjectStatus = .inProgress
    @State private var tasks: [Task] = []
    @State private var nextActions: [Task] = []
    @State private var waitingFors: [Task] = []
    @State private var isSettingsPopupVisible: Bool = false
    @State private var isEditThingViewVisible: Bool = false
    @State private var taskTypeTag = 0
    @State private var newThingName: String = ""
    @State private var tappedTaskID: UUID?
    @State private var isTaskInputMode = false

    private let appState: ProjectsAppStateProtocol
    private let projectsInteractor: ProjectsInteractorProtocol?
    private let tasksInteractor: TasksInteractorProtocol?
    private let router: IOS_Router
    private let placeholder = "Project name..."

    private var projectPublisher: AnyPublisher<Project, Never> {
        appState.getCurrentProject()
    }

    @State private var isTaskSectionVisible = false
    @State private var isWaitForSectionVisible = false
    @State private var isNextTaskSetionVisible = false
    @State private var isNotesSetionVisible = false
    
    init(projectsInteractor: InteractorProtocol,
         tasksInteractor: InteractorProtocol,
         appState: ProjectsAppStateProtocol,
         type: IOS_SType,
         router: IOS_Router) {
        self.projectsInteractor = projectsInteractor as? ProjectsInteractorProtocol
        self.tasksInteractor = tasksInteractor as? TasksInteractorProtocol
        self.appState = appState
        self.type = type
        self.router = router
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                titleView
                    .padding(.horizontal, 16)
                scrollView
                if type == .projectCreate {
                    buttonBar
                        .padding(.horizontal, 16)
                }
            }
            if isSettingsPopupVisible { settingsPopup }
            if isEditThingViewVisible { editThigPopup }
        }
        .modifier(NavigationBarModifier(type.title,
                                        leftImageView: AnyView(leftImage),
                                        leftButtonAction: {
            projectsInteractor?.setCurrentProject(id: nil)
            router.pop()
        },
                                        rightImageView: AnyView(rightImage),
                                        rightButtonAction: { isSettingsPopupVisible.toggle() },
                                        mainColor: .projectColor,
                                        identifier: .screenTitleProjectDetails))
        .onReceive(projectPublisher, perform: {
            update(project: $0)
        })
        .onAppear { fillInitialData() }
        .background(Color.backgroundMain.ignoresSafeArea())
    }

    // MARK: - Subviews

    private var leftImage: some View {
        Image.back.with(.medium, .projectColor)
    }

    private var rightImage: some View {
        Image.plus.with(.small, .projectColor).opacity(projectName.isEmpty ? 0 : 1)
    }

    private var scrollView: some View {
        ScrollViewReader { scrollView in
            ScrollView(.vertical, showsIndicators: false) {
                scrollContent
            }
            .onChange(of: isTaskInputMode) { isInputMode in
                if isInputMode {
                    withAnimation { scrollView.scrollTo(101, anchor: .zero) }
                } else {

                }
            }
        }
    }

    private var scrollContent: some View {
        VStack(spacing: 18) {
            if isNotesSetionVisible {
                notesView
            }
            if isNextTaskSetionVisible {
                nextActionsView
            }
            if isWaitForSectionVisible {
                waitingForsView
            }
            if isTaskSectionVisible {
                tasksView
                IOS_NewTaskView(isInputMode: $isTaskInputMode,
                                projectsInteractor: projectsInteractor).id(101)
            }

        }
        .padding()
    }

    private var titleView: some View {
        HStack(alignment: .top, spacing: 0) {
            IOS_CheckboxView(tapAction: {},
                             checkboxSize: .big)
                .padding(.top, 6)
            VStack(alignment: .leading) {
                TextFieldBig(inputText: $projectName,
                             placeholder: placeholder)
                    .padding(.leading, 3)
                StatusView(actualStatus: $projectStatus,
                           isEditingAllowed: true,
                           interactor: projectsInteractor)
            }
            .padding(.leading, 8)
            Spacer()
        }
    }

    private var notesView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !projectDescription.isEmpty {
                HStack {
                    Text("Notes")
                        .foregroundColor(.gray)
                    Spacer()
                }
                TextEditorDefault(inputText: $projectDescription)
                    .offset(x: -3)
            }
        }
    }

    private var settingsPopup: some View {
        IOS_GeneralActionsView(
            title: nil,
            items:
                [
                    (title: "Add task", action: {
                        isTaskInputMode = true
                        isTaskSectionVisible = true
                        Haptic.impact(.light)
                    }),
                    (title: "Add file", action: { print("filter tutaj action") }),
                    (title: "Add notes", action: { print("filter tutaj action") }),
                    (title: "Delete project", action: {
                        deleteProject()
                        router.pop()
                    }),
                ],
            closeAction: { isSettingsPopupVisible = false })
    }

    private var editThigPopup: some View {
        IOS_GeneralActionsView(
            title: "Move to",
            items:[
                (title: "Tasks", action: {
                    projectsInteractor?.editTypeInTaskInCurrentProject(taskId: tappedTaskID, taskType: TaskType.task)
                    isEditThingViewVisible = false
                }),
                (title: "Next actions", action: {                                     projectsInteractor?.editTypeInTaskInCurrentProject(taskId: tappedTaskID, taskType: .nextAction)
                    isEditThingViewVisible = false}),
                (title: "Wait for", action: {                                     projectsInteractor?.editTypeInTaskInCurrentProject(taskId: tappedTaskID, taskType: .waitingFor)
                    isEditThingViewVisible = false})
            ], closeAction: {
                isEditThingViewVisible = false
            }
        )
    }

    private var nextActionsView: some View {
        IOS_ProjectSubitemView(title: "Next actions",
                               items: nextActions.map { ($0.id, $0.name) }) { id in
            isEditThingViewVisible = true
            tappedTaskID = id
        }
    }

    private var waitingForsView: some View {
        IOS_ProjectSubitemView(title: "Waiting for",
                               items: waitingFors.map { ($0.id, $0.name) }) { id in
            isEditThingViewVisible = true
            tappedTaskID = id
        }
    }
    
    private var tasksView: some View {
            IOS_ProjectSubitemView(title: "Tasks",
                                   items: tasks.map { ($0.id, $0.name) }) { id in
                isEditThingViewVisible = true
                tappedTaskID = id}
    }
    
    @ViewBuilder private var buttonBar: some View {
            Button {
                saveAction()
                router.pop()
            } label: {
                Text("Save")
            }
            .buttonStyle(FilledButtonStyle(color: Color.projectColor))
    }

    // MARK: - Methods

    private func saveAction() {
        actions {
            projectsInteractor?.add(newName: projectName,
                                    newDescription: projectDescription,
                                    newTasks: tasks,
                                    status: projectStatus)
        } editing: {
            projectsInteractor?.editCurrentProject(newName: projectName,
                                                   newDescription: projectDescription,
                                                   newTasks: tasks,
                                                   status: projectStatus)
        }
    }

    private func deleteProject() {
        projectsInteractor?.deleteCurrentProject()
    }

    private func deleteTappedTask() {
        if let id = tappedTaskID {
            tasksInteractor?.deleteTask(id: id)
        }
    }

    private func fillInitialData() {
        actions {
            guard let existingProject = appState.getCurrentProject() else { return }
            projectName = existingProject.name
            projectDescription = existingProject.description ?? ""
            projectStatus = existingProject.status
            nextActions = appState.getNextActions()
            waitingFors = appState.getWaitingFors()
            projectDescription = appState.getNotes()
            tasks = existingProject.tasks
        }
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

    private func update(project: Project) {
        self.tasks = project.tasks
            .filter {
                $0.taskType != TaskType.waitingFor.name &&
                $0.taskType != TaskType.nextAction.name
            }
        nextActions = appState.getNextActions()
        waitingFors = appState.getWaitingFors()
        projectDescription = appState.getNotes()
        projectStatus = project.status
        updateSectionsVisibility()
    }

    private func updateSectionsVisibility() {
        isTaskSectionVisible = !tasks.isEmpty || isTaskInputMode
        isNotesSetionVisible = !projectDescription.isEmpty
        isWaitForSectionVisible = !waitingFors.isEmpty
        isNextTaskSetionVisible = !nextActions.isEmpty
    }

}
