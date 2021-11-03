//
//  NavigationBarModifier.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    
    let title: String?
    let leftButtonImage: Image?
    let leftButtonAction: (() -> Void)?
    let rightButtonImage: Image?
    let rightButtonAction: (() -> Void)?
    let syncDate: Binding<String?>?
    let mainColor: Color
    
    init(_ title: String? = nil,
         leftButtonImage: Image? = nil,
         leftButtonAction: (() -> Void)? = nil,
         rightButtonImage: Image? = nil,
         rightButtonAction: (() -> Void)? = nil,
         syncDate: Binding<String?>? = nil,
         mainColor: Color = .white) {
        self.title = title
        self.leftButtonImage = leftButtonImage
        self.leftButtonAction = leftButtonAction
        self.rightButtonImage = rightButtonImage
        self.rightButtonAction = rightButtonAction
        self.syncDate = syncDate
        self.mainColor = mainColor
    }
    
    func body(content: Content) -> some View {
        VStack {
            NavigationBar(syncDate: syncDate ?? .constant(nil),
                          title: title,
                          leftButtonImage: leftButtonImage,
                          leftButtonAction: leftButtonAction,
                          rightButtonImage: rightButtonImage,
                          rightButtonAction: rightButtonAction,
                          mainColor: mainColor)
            Spacer()
            content
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
    }
    
}
