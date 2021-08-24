//
//  CanvasView.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 04/08/2021.
//

import SwiftUI

struct CanvasScreen: View {
    
    @EnvironmentObject var container: Container
    @EnvironmentObject var router: IOSRouter

    var body: some View {
        VStack {
            switch router.type {
            case .tasks(let type):
                TaskDetailsScreen_mac(type: type)
            case .projects:
                InputDetailsScreen_mac()
            default:
                Text("Inboxes")
            }
        }
    }
    
}
