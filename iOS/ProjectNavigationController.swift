//
//  ProjectNavigationController.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct ProjectsNavigationController: NavigationController {
    
    @EnvironmentObject var container: Container
    
    func updateUIViewController(_ navigationController: UINavigationController, context: Context) {
        snapShotStackView(navigationController: navigationController,
                          container: container,
                          router: container.routerProjects)
    }
    
    func setInitialView() {
        container.routerProjects.setInitial(.projects)
    }
 
}
