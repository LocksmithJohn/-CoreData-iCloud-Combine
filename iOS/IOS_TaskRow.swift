//
//  IOS_TaskRow.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 27/08/2021.
//

import SwiftUI

struct IOS_TaskRow: View {

    let taskName: String
    let tapRowAction: () -> Void
    let checkboxAction: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            IOS_CheckboxView(tapAction: checkboxAction,
                             checkboxSize: .small)
            HStack {
                Text(taskName)
                    .font(.system(size: 20))
                Spacer()
            }
            .onTapGesture { tapRowAction() }
        }
    }
}
