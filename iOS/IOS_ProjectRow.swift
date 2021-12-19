//
//  IOS_ProjectRow.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 25/08/2021.
//

import SwiftUI

struct IOS_ProjectRow: View {
    
    @State private var toolViewPosition: CGFloat = 60
    @State private var cellSizeFactor: Double = 1
    @State private var cellReduced = false
    @State private var toolViewVisible = false

    private let project: Project // TODO: caly project jest za duzy do jednej komórki? downcast do czego mniejszego?
    private let toolViewWidth: CGFloat = 60
    private let projectsInteractor: ProjectsInteractorProtocol?

    init(projectsInteractor: ProjectsInteractorProtocol?,
         project: Project) {
        self.projectsInteractor = projectsInteractor
        self.project = project
    }

    private var texts: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(project.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white.opacity(cellSizeFactor == 1 ? 1 : 0.5))
            if let description = project.description {
                Text(description)
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(cellSizeFactor == 1 ? 1 : 0.5))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack(alignment: .leading) {
                texts
            }
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(Color.objectMain)
            .cornerRadius(12)
//            .border(Color.black, width: 1)
//            .scaleEffect(CGSize(width: cellSizeFactor, height: cellSizeFactor))
//            .animation(.linear(duration: 0.05), value: cellSizeFactor)
//            .onTapGesture {
//                toolViewVisible = false
//                cellReduced = false
//                resetFactors()
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        calculateFactors(gesture.translation.width)
//                    }
//                    .onEnded { gesture in
//                        toolViewPosition = toolViewWidth
//                        resetFactors()
//                    }
//            )
//            IOS_ToolView(toolViewPosition: $toolViewPosition,
//                     dismiss: { toolViewVisible = false },
//                     interactor: interactor,
//                     id: project.id)
        }
    }
    
    private func resetFactors() {
        if cellReduced {
            cellSizeFactor = 0.95
            toolViewPosition = 0

        } else {
            cellSizeFactor = 1
            toolViewPosition = toolViewWidth
        }
    }
    
    private func calculateFactors(_ gestureWidth: CGFloat) {
        if (-50 ... 0).contains(gestureWidth) {
            cellSizeFactor = Double(1 + gestureWidth / 1000)
        }
        
        if (-150 ..< -60).contains(gestureWidth) {
            toolViewPosition = toolViewWidth + gestureWidth
        }
        
        if gestureWidth < -120 && !toolViewVisible {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            toolViewVisible = true
                cellReduced = true
        }
        

    }
    
}
