//
//  ToolbarView.swift
//  Trening_icloud3 (macOS)
//
//  Created by User on 24/08/2021.
//

import Combine
import SwiftUI

struct MAC_ToolbarView: View {
    
    @EnvironmentObject var container: Container
    
    @State private var date: String?
    @State private var showingSheet = false
    
    var body: some View {
        HStack {
            if let date = date {
                Text(date)
            }
            Button(action: { 
                print("filter toolbar action") 
                showingSheet = true
            }, label: {
                Label("Record Progress", systemImage: "book.circle")
            })
                .sheet(isPresented: $showingSheet, onDismiss: nil) { 
                    VStack(spacing: 8) {
                        Text("111")
                        Text("222")
                        Text("333")
                        Text("444")
                    }
                    .frame(width: 300)
                    .onTapGesture {
                        showingSheet = false
                    }
                    
                }
        }
        .onReceive(datePublisher, perform: { date = $0 })
    }
    
    private var datePublisher: AnyPublisher<String?, Never> {
        container.appState.syncTimeSubject
            .eraseToAnyPublisher()
    }
    
}
