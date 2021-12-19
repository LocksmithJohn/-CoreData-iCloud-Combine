//
//  InputDetailsScreen.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct IOS_InputDetailsScreen: IOSScreen {
    
    @EnvironmentObject var container: Container
    var type = IOS_SType.inputDetails
    
    var body: some View {
        VStack {
            Spacer()            
        }
        .background(Color.white)
        .ignoresSafeArea()
        
        .modifier(NavigationBarModifier(type.title,
                                        leftImageView: AnyView(leftImage),
                                        leftButtonAction: { container.routerInbox.pop() },
                                        mainColor: .inboxColor,
                                        identifier: .screenTitleInbox))
    }

    private var leftImage: some View {
        Image(systemName: "arrowshape.turn.up.backward").foregroundColor(Color.inboxColor)
    }
}

struct InputDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        IOS_InputDetailsScreen()
    }
}
