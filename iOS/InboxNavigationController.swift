//
//  InboxNavigationController.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct InboxNavigationController: NavigationController {
    
    @EnvironmentObject var container: Container
    
    func updateUIViewController(_ navigationController: UINavigationController, context: Context) {
        snapShotStackView(navigationController: navigationController,
                          container: container,
                          router: container.routerInbox)
    }
    
    func setInitialView() {
        container.routerInbox.setInitial(.inbox)
    }
 
}
