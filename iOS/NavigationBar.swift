//
//  NavigationBar.swift
//  Light_Navigation_Architecture_on_Mac
//
//  Created by User on 03/08/2021.
//

import SwiftUI

struct NavigationBar: View {
    
    private enum Constants {
        static let height: CGFloat = 50
    }
    
    @Binding var syncDate: String?
    
    let title: String?
    let leftImageView: AnyView?
    let leftButtonAction: (() -> Void)?
    let rightImageView: AnyView?
    let rightButtonAction: (() -> Void)?
    let mainColor: Color
    let identifier: Identifier
    
    var body: some View {
        ZStack {
            if let title = title {
                Text(title)
                    .foregroundColor(mainColor)
                    .padding()
//                    .accessibilityIdentifier(accessibilityIdentifier)
                    .addIdentifier(identifier)
            }
            HStack {
                if let leftButtonImage = leftImageView {
                    Button(action: { leftButtonAction?() },
                           label: { leftButtonImage })
                        .padding()
                }
                Spacer()
                if let rightButtonImage = rightImageView {
                    Button(action: { rightButtonAction?() },
                           label: { rightButtonImage })
                        .padding()
                }
            }
            if let date = syncDate {
                HStack {
                    Spacer()
                    Text(date)
                        .font(.system(size: 12))
                        .padding()
                }
            }
        }
        .frame(height: Constants.height)
    }
}

extension View {
    func addIdentifier(_ identifier: Identifier) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        accessibilityIdentifier(identifier.rawValue)
    }
}
