//
//  TextEditor.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 06/09/2021.
//

import SwiftUI

struct TextEditorDefault: View {
    
    @Binding var inputText: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text("placeholder")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.projectColor.opacity(0.3))
//                .background(Color.pink)

            TextEditor(text: $inputText)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .lineLimit(1)
                .background(Color.pink)

        }
        .background(Color.red)
    }
    
}
