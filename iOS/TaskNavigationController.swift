//
//  TaskNavigationController.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct TasksNavigationController: NavigationController {
    
    @EnvironmentObject var container: Container
    @EnvironmentObject var router: IOS_Router


//    init(router: IOS_Router) {
//        self.router = router
//    }
    
    func updateUIViewController(_ navigationController: UINavigationController, context: Context) {
        snapShotStackView(navigationController: navigationController,
                          container: container,
                          router: router)
    }
    
    func setInitialView() {
        router.setInitial(.tasks)
    }
 
}
