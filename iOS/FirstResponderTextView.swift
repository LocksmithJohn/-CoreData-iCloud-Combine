//
//  FirstResponderTextView.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 12/12/2021.
//

import Combine
import SwiftUI


struct FirstResponderTextView: UIViewRepresentable {

    @Binding var text: String
    let endEditingSubject: () -> Void

    init(text: Binding<String>,
         endEditingSubject: @escaping () -> Void) {
        self._text = text
        self.endEditingSubject = endEditingSubject
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        var becameFirstResponder = false
        let endEditingSubject: () -> Void

        init(text: Binding<String>,
             textChangeSubject: @escaping () -> Void) {
            self._text = text
            self.endEditingSubject = textChangeSubject
        }

        func textViewDidChangeSelection(_ textView: UITextView) {
            text = textView.text ?? "tutaj"
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            endEditingSubject()
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if !text.contains("\n") {
                self.text = text
                return true
            } else {
                UIApplication.shared.windows.forEach { $0.endEditing(false) }
                return false
            }
        }
    }

    func makeUIView(context: Context) -> some UIView {
        let textView = UITextView()
        textView.returnKeyType = .done
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = .objectMain
        textView.tintColor = .green
        textView.text = text
        return textView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, textChangeSubject: endEditingSubject)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }


}
