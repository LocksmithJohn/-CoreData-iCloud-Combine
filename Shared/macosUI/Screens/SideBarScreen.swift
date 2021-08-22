//
//  SideBar.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct SideBarScreen: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        List {
            button(imageName: "1.circle", type: .inbox(.initial) )
            button(imageName: "2.circle", type: .tasks(.initial))
            button(imageName: "3.circle", type: .projects(.initial))
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 150, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
        .padding(.top, 16)
    }
    
    private func button(imageName: String, type: MiddleType) -> some View {
        Button {
            router.type = type
        } label: {
            HStack {
                Image(systemName: imageName)
                Text(type.title ?? "").padding()
            }
        }
        .buttonStyle(LinkButtonStyle())
    }
}
