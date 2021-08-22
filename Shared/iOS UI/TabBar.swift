//
//  TabBar.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct TabBar: View {
    
    @EnvironmentObject var container: Container
    
    var body: some View {
        TabView {
            InboxNavigationController()
                .environmentObject(container)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Inbox")
                }.tag(1)
            TasksNavigationController()
                .environmentObject(container)
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Tasks")
                }.tag(2)
            ProjectsNavigationController()
                .environmentObject(container)
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Projects")
                }.tag(1)
        }    }
}
