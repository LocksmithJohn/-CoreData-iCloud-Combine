//
//  TextFieldSmall.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 06/09/2021.
//

import Foundation

import SwiftUI

struct TextFieldSmall: View {
    
    @Binding var inputText: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $inputText)
            .textFieldStyle(PlainTextFieldStyle())
            .font(.system(size: 24, weight: .regular, design: .rounded))
            .padding()
    }
}
