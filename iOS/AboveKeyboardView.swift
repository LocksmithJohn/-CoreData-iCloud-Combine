//
//  AboveKeyboardView.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 26/08/2021.
//

import SwiftUI

struct AboveKeyboardView: View {
    
    @Binding var isExpanded: Bool
    @Binding var taskname: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            TextField("new task", text: $taskname)
                .font(.title)
                .padding()
                .frame(maxWidth:.infinity)
                .frame(height: 50)
            if isExpanded {
                Button(action: { action() }, label: { Text("Ok") })
                    .buttonStyle(FilledButtonStyle(color: Color.yellow))
                    .frame(width: 100, height: 40)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)//isExpanded ? 100 : 60)
        .background(isExpanded ? Color.gray.opacity(0.1) : Color.clear)
        .cornerRadius(10)
        //        .offset(y: 10.0)
    }
}
