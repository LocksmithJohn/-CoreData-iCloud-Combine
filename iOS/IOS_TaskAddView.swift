//
//  IOS_TaskAddView.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 29/11/2021.
//

import SwiftUI

struct IOS_TaskAddView: View {

    var title: String
    @Binding var isVisible: Bool
    @Binding var selectionTag: Int
    @Binding var newThingName: String
    @Binding var notes: String

    let addAction: () -> Void

    var body: some View {
        ZStack {
            Color.red
            popoup
                .frame(width: 300, height: 300, alignment: .center)
        }
    }

    private var popoup: some View {
        VStack(spacing: 40) {
            Text("Add to \(title)")
                .font(.system(size: 32))
            Picker("Add", selection: $selectionTag) {
                Text("Task").tag(0)
                Text("Next action").tag(1)
                Text("Waiting for").tag(2)
                Text("Notes").tag(3)
            }
            .pickerStyle(.segmented)
            if selectionTag == 3 {
                TextEditorDefault(inputText: $notes)
                    .frame(height: 100)
            } else {
                TextFieldBig(inputText: $newThingName, placeholder: "...")
                    .frame(height: 30)
            }

            Button {
                addAction()
                isVisible = false
            } label: {
                Text("Add")
            }

        }
        .padding()
        .background(BlurredView())
        .cornerRadius(10)
    }


}
