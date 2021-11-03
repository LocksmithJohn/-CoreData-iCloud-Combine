//
//  UITestsBasicNavigation.swift
//  UITests
//
//  Created by Jan Slusarz on 03/11/2021.
//

import XCTest

class UITestsBasicNavigation: XCTestCase {

    override class func setUp() {
        app.launch()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testScreensOnTabs() {
        UITestsTabbarProvider(app: app)
            .tapInboxTab()
            .checkTasksScreenExistance()
            .tapTasksTab()
            .checkTasksScreenExistance()
            .tapProjectsTab()
            .checkProjectsScreenExistance()
    }
    
}
