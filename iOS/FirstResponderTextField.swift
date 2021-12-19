//
//  FirstResponderTextField.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 12/12/2021.
//

import SwiftUI

struct FirstResponderTextField: UIViewRepresentable {

    @Binding var text: String

    init(text: Binding<String>) {
        self._text = text
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var becameFirstResponder = false

        init(text: Binding<String>) {
            self._text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? "tutaj"
        }
    }

    func makeUIView(context: Context) -> some UIView {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }


}
