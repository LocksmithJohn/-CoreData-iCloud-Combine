//
//  MAC_SideBarScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct MAC_SideBarScreen: View {
    
    @State private var router: MAC_Router
    
    init(router:  MAC_Router) {
        self.router = router
    }
    
    var body: some View {
        List {
            button(imageName: "1.circle", route: .inbox(.creating) )
            button(imageName: "2.circle", route: .tasks(.creating))
            button(imageName: "3.circle", route: .projects(.creating))
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 150, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
        .padding(.top, 16)
    }
    
    private func button(imageName: String, route: Route) -> some View {
        Button {
            router.route.send(route)
        } label: {
            HStack {
                Image(systemName: imageName)
                Text(route.title ?? "").padding()
            }
        }
        .buttonStyle(LinkButtonStyle())
    }

}
