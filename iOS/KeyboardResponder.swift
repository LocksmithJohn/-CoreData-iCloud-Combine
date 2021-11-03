//
//  KeyboardResponder.swift
//  Trening_icloud3
//
//  Created by User on 26/08/2021.
//

import Combine
import SwiftUI

final class KeyboardResponder: ObservableObject {

    private var notificationCenter: NotificationCenter
    private var bags = Set<AnyCancellable>()
    @Published private(set) var currentHeight: CGFloat = 0
    @Published private(set) var isVisible: Bool = false

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        $currentHeight
            .map { $0 != 0 }
            .sink { [weak self] in self?.isVisible = $0 }
            .store(in: &bags)
    }

    func dismiss() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}
