//
//  MacView.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct MacView: View {
    
    @EnvironmentObject var container: Container
    
    var body: some View {
        NavigationView {
            SideBarScreen().environmentObject(container.router)
            MiddleBarScreen().environmentObject(container.router)
            CanvasScreen().environmentObject(container.router)
        }
        .toolbar {
            ToolbarView().environmentObject(container)
        }
    }
}
