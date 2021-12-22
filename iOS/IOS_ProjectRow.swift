//
//  IOS_ProjectRow.swift
//  Trening_icloud3 (iOS)
//
//  Created by User on 25/08/2021.
//

import SwiftUI

struct IOS_ProjectRow: View {

    private let projectName: String
    private let projectStatus: ProjectStatus

    init(projectName: String,
         projectStatus: ProjectStatus) {
        self.projectName = projectName
        self.projectStatus = projectStatus
    }

    private var texts: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(Color.projectColor)
                .frame(width: 8, height: 8)
                .padding(.trailing, 14)
                .padding(.top, 7)
            Text(projectName)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            StatusView(actualStatus: .constant(projectStatus), interactor: nil)
        }
        .frame(maxWidth: .infinity)
    }
    
    var body: some View {
        texts
            .frame(maxWidth: .infinity)
    }

}
