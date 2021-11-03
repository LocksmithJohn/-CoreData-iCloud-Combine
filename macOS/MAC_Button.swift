//
//  MAC_Button.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 04/08/2021.
//

import SwiftUI

struct MAC_Button: View {
    
    let action: () -> Void
    let label: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .padding(10)
        }
        .background(Color.blue)
//        .background(Color.white.opacity(0.05))
        .cornerRadius(6)
        .buttonStyle(PlainButtonStyle())

    }
}
