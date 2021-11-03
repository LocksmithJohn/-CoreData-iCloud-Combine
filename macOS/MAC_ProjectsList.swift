//
//  ProjectsList.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 04/08/2021.
//

import SwiftUI

struct MAC_ProjectsList: View {
    
    @Binding var projects: [Project]
    
    private let router: MAC_Router
    private let interactor: ProjectsInteractorProtocol?
    
    init(router: MAC_Router,
         interactor: ProjectsInteractorProtocol?,
         projects: Binding<[Project]>) {
        self.router = router
        self.interactor = interactor
        _projects = projects
    }

    var body: some View {
        VStack {
            List {
                ForEach(projects, id: \.self) { project in
                    HStack {
                        Text("•")
                            .font(.system(size: 30))
                            .padding(.leading, 16)
                            .foregroundColor(.projectColor)
                        Text(project.name)
                        Spacer()
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onTapGesture {
                        interactor?.setCurrentProject(id: project.id)
                        router.route.send(.projects(.editing))
                    }
                    
                }
            }
            MAC_Button(action: {
                router.route.send(.projects(.creating))
            }, label: "Add Project")
            .padding()
        }
    }
    
}
