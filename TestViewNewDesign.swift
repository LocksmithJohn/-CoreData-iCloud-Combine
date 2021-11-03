//
//  TestViewNewDesign.swift
//  Trening_icloud3 (iOS)
//
//  Created by Jan Slusarz on 13/09/2021.
//

import SwiftUI

struct TestViewNewDesign: View {
    
    private let grayMy: Color = Color.gray.opacity(0.6)
    var body: some View {
        VStack {
            Spacer()
            VStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(grayMy)
                    .frame(width: 50, height: 4, alignment: .center)
                    .padding(.top, 10)
                    .padding(.bottom, 6)
                buttonsInfoRowView
                settingsRow
                horizontalLine
                Spacer()
                tabbarRow
            }
            //        .background(Gradient(colors: [Color.black, Color("customGray")]))
                    .frame(height: 200)
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    Color("customGray"),
                    Color("customGrayDarker")
                ]), startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(10)
//            .padding(4)
            .clipped()
        }
    }
    
    private var buttonsInfoRowView: some View {
        HStack {
            Image(systemName: "ellipsis.rectangle")
                .foregroundColor(grayMy)
                .font(.system(size: 30))
                .padding(.trailing, 6)
            Image(systemName: "ellipsis.rectangle")
                .foregroundColor(.white)
                .shadow(color: .white, radius: 1.5)
                .font(.system(size: 30))
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("Yesterday, 6:04 AM")
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 1.5)
                Text("Desolation Wilderness, CA")
                    .foregroundColor(grayMy)
            }.font(.system(size: 15))
        }
        .padding(.horizontal, 16)
    }
    
    private var verticalSpacer: some View {
        Rectangle()
            .fill(grayMy)
            .frame(width: 1, height: 24)
            .opacity(0.5)
    }
    
    private var horizontalLine: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(grayMy.opacity(0.8))
            .frame(height: 3)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)

            .opacity(0.4)
    }
    
    private var settingsRow: some View {
        HStack {
            labelMy(image: "tray.and.arrow.down", text: "1/200s")
            Spacer()
            verticalSpacer
            Spacer()
            labelMy(image: "square.stack.3d.forward.dottedline", text: "ISO 892")
            Spacer()
            verticalSpacer
            Spacer()
            labelMy(image: "tray.and.arrow.down", text: "52mm")
        }
        .padding(.horizontal, 26)
    }
    
    private func labelMy(image: String, text: String) -> some View {
        HStack {
            Image(systemName: image)
                .accentColor(.blue)
                .foregroundColor(grayMy)
                .font(.system(size: 19))
            Text(text)
                .foregroundColor(grayMy)
                .font(.system(size: 13, weight: .medium))
        }
    }
    
    private var tabbarRow: some View {
        HStack {
            Image(systemName: "heart")
            Spacer()
            Image(systemName: "triangle.circle")
            Spacer()
            Image(systemName: "square.and.arrow.up")
            Spacer()
            Image(systemName: "trash")
        }
        .padding(.horizontal, 16)
        .foregroundColor(grayMy)
        .font(.system(size: 26))
        .padding(.bottom, 32)
    }
    
}

struct TestViewNewDesign_Previews: PreviewProvider {
    static var previews: some View {
        TestViewNewDesign()
    }
}
