//
//  owt_tiny_mvvmUITests.swift
//  owt-tiny-mvvmUITests
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import XCTest

class owt_tiny_mvvmUITests: XCTestCase {

    var app: XCUIApplication!

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUITransformUrl() {                     
        app.navigationBars["owt_tiny_mvvm.HomeView"].buttons["Item"].tap()
        
        app.buttons["Transform URL"].tap()
        XCTAssertTrue(app.buttons["Transform URL"].exists)
        XCTAssertFalse(!app.buttons["Transform URL"].exists)
        
        app.textFields["Paste long Url"].tap()
        XCTAssertTrue(app.textFields["Paste long Url"].exists)
        XCTAssertFalse(!app.textFields["Paste long Url"].exists)
    }

}
