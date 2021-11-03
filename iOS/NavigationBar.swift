//
//  NavigationBar.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct NavigationBar: View {
    
    private enum Constants {
        static let height: CGFloat = 50
    }
    
    @Binding var syncDate: String?
    
    let title: String?
    let leftButtonImage: Image?
    let leftButtonAction: (() -> Void)?
    let rightButtonImage: Image?
    let rightButtonAction: (() -> Void)?
    let mainColor: Color
    
    var body: some View {
        ZStack {
            if let title = title {
                Text(title)
                    .foregroundColor(mainColor)
                    .padding()
            }
            HStack {
                if let leftButtonImage = leftButtonImage {
                    Button(action: { leftButtonAction?() },
                           label: { leftButtonImage })
                        .padding()
                }
                Spacer()
                if let rightButtonImage = rightButtonImage {
                    Button(action: { leftButtonAction?() },
                           label: { rightButtonImage })
                        .padding()
                }
            }
            if let date = syncDate {
                HStack {
                    Spacer()
                    Text(date)
                        .font(.system(size: 12))
                        .padding()
                }
            }
        }
        .frame(height: Constants.height)
    }
}
