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

    func tapInboxTab() -> Self {
        let button = app.buttons["tab inbox"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        return self
    }

    func tapTasksTab() -> Self {
        let button = app.buttons["tab tasks"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        app.debugPrint()
        return self
    }

    func tapProjectsTab() -> Self {
        let button = app.buttons["tab projects"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
        return self
    }

    func checkInboxScreenExistance() -> Self {
        let title = app.staticTexts["screenTitleInbox"]
        XCTAssertTrue(title.waitForExistence(timeout: 3))
        return self
    }

    func checkTasksScreenExistance() -> Self {
        let title = app.staticTexts["screenTitleTasks"]
        XCTAssertTrue(title.waitForExistence(timeout: 3))
        return self
    }

    func checkProjectsScreenExistance() -> Self {
        let title = app.staticTexts["screenTitleProjects"]
        XCTAssertTrue(title.waitForExistence(timeout: 3))
        return self
    }

}
