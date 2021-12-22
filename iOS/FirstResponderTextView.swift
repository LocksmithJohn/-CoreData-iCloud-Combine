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
    private let endEditingAction: (String) -> Void
    private let backgroundColor: Color
    private let textColor: Color
    private let textSize: CGFloat

    init(text: Binding<String>,
         textColor: Color = .white,
         textSize: CGFloat = 18,
         backgroundColor: Color = .objectMain,
         endEditingAction: @escaping (String) -> Void) {
        self._text = text
        self.textSize = textSize
        self.endEditingAction = endEditingAction
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        var becameFirstResponder = false
        let endEditingAction: (String) -> Void

        init(text: Binding<String>,
             endEditingAction: @escaping (String) -> Void) {
            self._text = text
            self.endEditingAction = endEditingAction
        }

        func textViewDidChangeSelection(_ textView: UITextView) {
            text = textView.text ?? "tutaj"
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            endEditingAction(textView.text)
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
        textView.font = UIFont.systemFont(ofSize: textSize)
        textView.backgroundColor = UIColor(backgroundColor)
        textView.tintColor = UIColor(textColor)
        textView.text = text
        return textView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, endEditingAction: endEditingAction)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }


}
