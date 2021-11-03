//
//  StackScreenViewController.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Foundation
import SwiftUI

class StackScreenViewController: UIHostingController<AnyView> {
    var container: Container
    var type: IOS_SType { didSet {
        rootView = ScreenFactory.make(type: type, container: container)
    } }

    init(container: Container, type: IOS_SType) {
        self.container = container
        self.type = type
        super.init(rootView: ScreenFactory.make(type: type, container: container))
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.title = type.title
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
}

class Screen: Equatable {
    
    var isModal = false
    var type = IOS_SType.tasks
    
    init(type: IOS_SType) {
        self.type = type
    }
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.type == rhs.type
    }
    
}
