//
//  Color+Extensions.swift
//  Trening_icloud3
//
//  Created by Jan Slusarz on 09/09/2021.
//

import Foundation
import SwiftUI

extension Color {
    
    static var taskColor: Color { Color.blue }
    static var projectColor: Color { Color.green }
    static var inboxColor: Color { Color.yellow }

    static var backgroundMain: Color { Color("backgroundMain", bundle: nil) }
    static var objectMain: Color { Color("objectMain", bundle: nil) }
    
}

#if !os(macOS)

import UIKit

public extension UIColor {
    static var backgroundMain: UIColor { UIColor(Color.backgroundMain) }
    static var objectMain: UIColor { UIColor(Color.objectMain) }
}

#endif
