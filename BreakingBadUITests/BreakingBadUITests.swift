//
//  BreakingBadUITests.swift
//  BreakingBadUITests
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import XCTest

class BreakingBadUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        
    }

    
    func testDisplayCorrectCharacterLabelsOnTap() throws {
        let characterName = "Walter White"
        let nickname = "Heisenberg"
        let app = XCUIApplication()
        app.activate()
        let characterCell = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Walter White"]/*[[".cells.staticTexts[\"Walter White\"]",".staticTexts[\"Walter White\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        expectation(for: NSPredicate(format: "exists = 1"), evaluatedWith: characterCell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        characterCell.tap()
        
        XCTAssertTrue(app.scrollViews.otherElements.staticTexts[characterName].exists)
        XCTAssertTrue(app.scrollViews.otherElements.staticTexts[nickname].exists)
        
    }
    
    
    func testDisplayCorrectCharactersFromSearch() throws {
        let app = XCUIApplication()
        app.activate()
        let characterCell = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Walter White"]/*[[".cells.staticTexts[\"Walter White\"]",".staticTexts[\"Walter White\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        expectation(for: NSPredicate(format: "exists = 1"), evaluatedWith: characterCell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(app.searchFields["Search for a character"].exists)
        let searchBar = app.searchFields["Search for a character"]
        searchBar.tap()
        searchBar.typeText("Walt")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.tables.staticTexts["Walter White"].exists)
        XCTAssertTrue(app.tables.staticTexts["Walter White Jr."].exists)
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
