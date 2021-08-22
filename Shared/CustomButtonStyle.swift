//
//  CustomButtonStyle.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var color: Color = .blue
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 300)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
