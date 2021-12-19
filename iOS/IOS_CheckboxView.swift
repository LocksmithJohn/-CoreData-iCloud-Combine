//
//  IOS_CheckboxView.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 29/11/2021.
//

import SwiftUI

struct IOS_CheckboxView: View {

    let tapAction: () -> Void
    let checkboxSize: CheckboxSize

    @State private var isSelected = false

    var body: some View {
        Button {
            tapAction()
            isSelected.toggle()
        } label: {
            Image(systemName: isSelected ? "circle.fill" : "circle")
                .font(.system(size: checkboxSize.rawValue))
                .foregroundColor(isSelected ? .white : .gray)
        }
    }
}

enum CheckboxSize: CGFloat {
    case small = 20
    case big = 32
}
