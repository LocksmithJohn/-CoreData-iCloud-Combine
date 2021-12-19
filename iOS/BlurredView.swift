//
//  BlurredView.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 08/12/2021.
//

import SwiftUI

struct BlurredView: UIViewRepresentable {
    typealias UIViewType = UIVisualEffectView

    let style: UIBlurEffect.Style

    init(style: UIBlurEffect.Style = .systemMaterial) {
        self.style = style
    }

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: self.style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: self.style)
    }
}
