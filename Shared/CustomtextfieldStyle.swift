//
//  CustomtextfieldStyle.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import Foundation

import SwiftUI

struct CustomTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(width: 300)
            .padding()
//            .foregroundColor(.black)
            .cornerRadius(10)
            .font(.system(size: 30))
    }
    
}
