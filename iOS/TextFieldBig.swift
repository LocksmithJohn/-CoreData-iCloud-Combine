//
//  TextFieldBig.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 06/09/2021.
//

import SwiftUI

struct TextFieldBig: View {
    
    @Binding var inputText: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $inputText)
            .textFieldStyle(PlainTextFieldStyle())
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .padding()
    }
}
