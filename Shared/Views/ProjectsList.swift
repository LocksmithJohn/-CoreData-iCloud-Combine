//
//  ProjectsList.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 04/08/2021.
//

import SwiftUI

struct ProjectsList: View {
    
    @Binding var projectsNames: [String]

    var body: some View {
        List {
            ForEach(projectsNames, id: \.self) { task in
                Text(task)
            }
        }
    }
    
}
