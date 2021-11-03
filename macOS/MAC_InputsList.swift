//
//  InputsNames.swift
//  Light_Navigation_Architecture_on_Mac (macOS)
//
//  Created by User on 04/08/2021.
//

import SwiftUI

struct MAC_InputsList: View {
    
    @Binding var inputsNames: [String]

    var body: some View {
        List {
            ForEach(inputsNames, id: \.self) { task in
                Text(task)
            }
        }
    }
    
}
