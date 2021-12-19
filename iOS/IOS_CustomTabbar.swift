//
//  IOS_CustomTabbar.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 08/12/2021.
//

import SwiftUI

struct IOS_CustomTabbar: View {

    @EnvironmentObject var container: Container

    @State private var tabSelected = 0

    var body: some View {
        VStack(spacing: 0) {
            if container.appState.isTabbarVisibleSubject.value {
                switch tabSelected {
                case 0:
                    InboxNavigationController()
                        .environmentObject(container)
                case 1:
                    TasksNavigationController()
                        .environmentObject(container)
                default:
                    ProjectsNavigationController()
                        .environmentObject(container)
                }
                HStack {
                    tabItem(iconName: "tray.and.arrow.down",
                            text: "Inbox",
                            tag: 0,
                            color: .inboxColor)
                    Spacer()
                    tabItem(iconName: "list.bullet",
                            text: "Tasks",
                            tag: 1,
                            color: .taskColor)
                    Spacer()
                    tabItem(iconName: "doc.on.doc",
                            text: "Projects",
                            tag: 2,
                            color: .projectColor)
                }
                .padding(.bottom, 30)
                .padding(.horizontal, 30)
            }
        }
        .background(Color.backgroundMain)
    }

    private func tabItem(iconName: String,
                         text: String,
                         tag: Int,
                         color: Color) -> some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: iconName)
                .foregroundColor(tabSelected == tag ? color : .gray)
                .frame(height: 40)
            Text(text).font(.system(size: 14))
                .foregroundColor(tabSelected == tag ? color : .gray)
        }
        .frame(width: 80, height: 80)
        .contentShape(Rectangle())
        .onTapGesture {
            tabSelected = tag
            Haptic.impact(.light)
        }
    }
}
