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
        app.debugPrint()
        let button = app.buttons[Identifier.tabBarTabInbox.rawValue]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        return self
    }
    
    @discardableResult
    func tapTasksTab() -> Self {
        let button = app.buttons[Identifier.tabBarTabTasks.rawValue]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        app.debugPrint()
        return self
    }

    @discardableResult
    func tapProjectsTab() -> Self {
        let button = app.buttons[Identifier.tabBarTabProjects.rawValue]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        return self
    }

    @discardableResult
    func checkInboxScreenExistance() -> Self {
        checkForExtistance(elementType: .staticText, identifier: .screenTitleInbox)
    }

    @discardableResult
    func checkTasksScreenExistance() -> Self {
        checkForExtistance(elementType: .staticText, identifier: .screenTitleTasks)
    }

    @discardableResult
    func checkProjectsScreenExistance() -> Self {
        checkForExtistance(elementType: .staticText, identifier: .screenTitleProjects)
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
