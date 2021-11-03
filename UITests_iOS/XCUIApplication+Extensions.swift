//
//  XCUIApplication+Extensions.swift
//  UITests
//
//  Created by Jan Slusarz on 03/11/2021.
//

import Foundation
import XCTest

extension XCUIApplication {

    func debugPrint() {
        var string = XCUIApplication().debugDescription
        string = Array(arrayLiteral: string)
            .reduce("") { $0 + ($1 == "" ? "\n" : $1) }
        print(string)
    }

}
