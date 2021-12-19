//
//  IOS_ProjectSubitemView.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 29/11/2021.
//

import SwiftUI

struct IOS_ProjectSubitemView: View {

    @State var inputText: String = ""

    let title: String
    let items: [(itemId: UUID, name: String)]
    let tappedID: (UUID) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !items.isEmpty {
                HStack {
                    Text(title)
                        .foregroundColor(.gray)
                    Spacer()
                }
                ForEach(items, id: \.itemId) { item in
                    VStack {
                        IOS_TaskRow(taskName: item.name,
                                    tapRowAction: { tappedID(item.itemId) },
                                    checkboxAction: {})
                    }
                }
            }
        }
    }

}
