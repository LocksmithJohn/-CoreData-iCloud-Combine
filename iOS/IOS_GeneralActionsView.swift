//
//  IOS_GeneralActionsView.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 29/11/2021.
//

import SwiftUI

struct IOS_GeneralActionsView: View {

    let title: String?
    let items: [(title: String, action: () -> Void)]
    let closeAction: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    closeAction()
                }
            VStack(alignment: .leading, spacing: 16) {
                if let title = title {
                    Text(title)
                }
                ForEach(items, id:\.title) { item in
                    Text(item.title)
                        .onTapGesture {
                            item.action()
                            closeAction()
                        }
                }
            }
            .padding()
            .frame(width: 200)
            .background(Color.objectMain)
            .cornerRadius(10)
        }
    }
}
