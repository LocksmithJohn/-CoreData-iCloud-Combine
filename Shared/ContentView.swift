//
//  ContentView.swift
//  Shared
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    let container: Container
    var body: some View {
        
#if os(macOS)
        MAC_View().environmentObject(container)
#else
        IOS_CustomTabbar().environmentObject(container)
//            .popupModifier(popupType: container.appState.popupType)
#endif
    }
}
