//
//  TextFieldSmall.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 06/09/2021.
//

import Foundation

import SwiftUI
import Combine

struct CustomTextField: View {

    @Binding var inputText: String
    let placeholder: String
    let returnAction: () -> Void

    var body: some View {
//                if #available(iOS 15.0, *) {
//                    CustomTextField_IOS15(returnAction: { returnAction() },
//                                          placeholder: placeholder,
//                                          text: $inputText)
//                } else {
        HStack {
            TextField(placeholder, text: $inputText) { value in
            } onCommit: {
                returnAction()
            }

//            TextField(placeholder, text: $inputText, onCommit:  {
//                returnAction()
//            })
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .padding(.leading, 16)
        }
    }
}


@available(iOS 15.0, *)
struct CustomTextField_IOS15: View {

    enum FocusField: Hashable {
        case field
    }

    @FocusState private var focusedField: FocusField?

    var returnAction: () -> Void
    var placeholder: String
    @Binding var text: String

    init(returnAction: @escaping () -> Void,
         placeholder: String,
         text: Binding<String>
    ) {
        _text = text
        self.placeholder = placeholder
        self.returnAction = returnAction
        focusedField = .field
    }

    var body: some View {
        TextField(placeholder, text: $text)
            .onSubmit {
                returnAction()
            }
            .focused($focusedField, equals: .field)
            .background(Color.red)
            .onAppear {
                focusedField = .field
            }
    }
}
