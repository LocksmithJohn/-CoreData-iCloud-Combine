//
//  StatusView.swift
//  Trening_icloud3
//
//  Created by Jan Slusarz on 19/12/2021.
//

import SwiftUI

struct StatusView: View {

    @Binding var actualStatus: ProjectStatus
    private let interactor: ProjectsInteractorProtocol?
    private let isEditingAllowed: Bool

    init(actualStatus: Binding<ProjectStatus>,
         isEditingAllowed: Bool = false,
         interactor: ProjectsInteractorProtocol?) {
        _actualStatus = actualStatus
        self.interactor = interactor
        self.isEditingAllowed = isEditingAllowed
    }
    var statuses: [ProjectStatus] {
        [.new, .inProgress, .done]
            .filter { $0 != actualStatus }
    }

    @State private var isExpanded = false

    var body: some View {
        VStack {
            Text(actualStatus.name)
                .font(.system(size: 15))
                .onTapGesture {
                    if isEditingAllowed {
                        isExpanded.toggle()
                        Haptic.impact(.light)
                    }
                }
                .padding(2)
            if isExpanded {
                ForEach(statuses) { status in
                    Text(status.name)
                        .font(.system(size: 16))
                        .onTapGesture {
                            isExpanded = false
                            Haptic.impact(.light)
                            interactor?.editCurrentProject(newName: nil, newDescription: nil, newTasks: nil, status: status)
                        }
                        .padding(2)
                }
            }
        }
        .frame(width: 100)
        .background(Color.objectMain)
        .cornerRadius(6)
    }

}
