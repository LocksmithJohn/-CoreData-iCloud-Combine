//
//  UITestsTabbarProvider.swift
//  UITests
//
//  Created by Jan Slusarz on 03/11/2021.
//

import Foundation
import XCTest


struct UITestsTabbarProvider: UITestProviderProtocol {
    var app: XCUIApplication

    @discardableResult
    func tapInboxTab() -> Self {
        let button = app.buttons["tab inbox"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        return self
    }
    
    @discardableResult
    func tapTasksTab() -> Self {
        let button = app.buttons["tab tasks"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        app.debugPrint()
        return self
    }

    @discardableResult
    func tapProjectsTab() -> Self {
        let button = app.buttons["tab projects"] // TODO: write ids properly
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        return self
    }

    @discardableResult
    func checkInboxScreenExistance() -> Self {
        let title = app.staticTexts["screenTitleInbox"]
        XCTAssertTrue(title.waitForExistence(timeout: 3))
        return self
    }

    @discardableResult
    func checkTasksScreenExistance() -> Self {
        checkForExtistance(elementType: .staticText, identifier: .screenTitleTasks)
    }

    @discardableResult
    func checkProjectsScreenExistance() -> Self {
        let title = app.staticTexts["screenTitleProjects"]
        XCTAssertTrue(title.waitForExistence(timeout: 3))
        return self
    }

    func checkForExtistance(elementType: UIElementType,
                            identifier: Identifier) -> Self {
        let element = app.getElement(elementType: elementType,
                                     identifier: identifier)
        XCTAssertTrue(element.waitForExistence(timeout: 3), identifier.assertMessage)
        return self
    }

}

extension XCUIApplication {
    func getElement(elementType: UIElementType, identifier: Identifier) -> XCUIElement {
        switch elementType {
        case .button:
            return buttons[identifier.rawValue]
        case .image:
            return images[identifier.rawValue]
        case .textField:
            return textFields[identifier.rawValue]
        case .staticText:
            return staticTexts[identifier.rawValue]
        case .other:
            return otherElements[ identifier.rawValue]
        }
    }
}

enum UIElementType {
    case button
    case image
    case textField
    case other
    case staticText
}
