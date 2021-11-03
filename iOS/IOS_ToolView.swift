//
//  IOS_ToolView.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 27/08/2021.
//

import SwiftUI

struct IOS_ToolView: View {
    
    @Binding var toolViewPosition: CGFloat
    let dismiss: () -> Void
    let interactor: ProjectsInteractorProtocol
    let id: UUID
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                interactor.deleteProject(id) // tutaj stad akcje do superwidoku
                dismiss()
            }, label: {
                Image(systemName: "trash").accentColor(.white)
            })
            .frame(width: 60, height: 60)
            Button(action: {
//                interactor.editProject(newName: <#T##String#>, newDescription: <#T##String#>)
                dismiss()
            }, label: {
                Image(systemName: "square.and.pencil").accentColor(.white)
            })
            .frame(width: 60, height: 60)
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrowshape.turn.up.right").accentColor(.white)
            })
            .frame(width: 60, height: 60)
        }
//        .padding(.top, 16)
        .background(Color.gray)
        .cornerRadius(8)
        .offset(x: toolViewPosition)
        .animation(.linear(duration: 0.1), value: toolViewPosition)
    }

}

enum ToolViewType {
    
    case projectRow
    case taskRow
    
}
