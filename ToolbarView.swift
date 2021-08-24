//
//  ToolbarView.swift
//  Trening_icloud3 (macOS)
//
//  Created by User on 24/08/2021.
//

import SwiftUI

struct ToolbarView: View {
    
    @EnvironmentObject var container: Container
    
    @State private var date: String?
    
    var body: some View {
        HStack {
            if let date = date {
                Text(date)
            }
            Button(action: { print("filter toolbar action") }, label: {
                Label("Record Progress", systemImage: "book.circle")
            })
        }
        .onReceive(datePublisher, perform: { date = $0 })
    }
    
    private var datePublisher: MyAnyPublisher<String?> {
        container.appState.syncTimeSubject
            .eraseToAnyPublisher()
    }
    
}
