//
//  PopupModifier.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 10/12/2021.
//

import SwiftUI

//struct PopupModifier: ViewModifier {
//    var popupView: AnyView?
//
//    func body(content: Content) -> some View {
//        ZStack {
//            content
//            if let popupView = popupView {
//                popupView
//            }
//        }
//    }
//}
//
//extension View {
//    func popupModifier(popupType: PopupType) -> some View {
//        modifier(PopupModifier(popupView: popupView))
//    }
//}
//
//
//enum PopupType {
//    case addThing()
//}

//struct Popup: View {
//    var type: PopupType
//
//    var body: some View {
//        switch type {
//        case .addThing:
//            IOS_TaskAddView(
//                title: "projectName",
//                isVisible: true,
//                selectionTag: $taskTypeTag,
//                newThingName: $newThingName,
//                notes: $projectNotes,
//                addAction: {
//                    projectsInteractor?.addTaskToCurrentProject(task: Task(name: newThingName,
//                                                                           description: nil,
//                                                                           parentProject: "",
//                                                                           taskType: TaskType(rawValue: taskTypeTag)?.name))
//                }
//            )
//        }
//    }
//}
