//
//  MacView.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct MAC_View: View {
    
    @EnvironmentObject var container: Container
    
    var body: some View {
        NavigationView {
            MAC_SideBarScreen(router: container.router)
            MAC_MiddleBarScreen(container: container)
            MAC_CanvasScreen(appState: container.appState,
                             router: container.router,
                             interactor: container.interactor)
        }
        .toolbar {
            MAC_ToolbarView().environmentObject(container)
        }
    }
}
