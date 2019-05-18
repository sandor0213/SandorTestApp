//
//  SandorTestAppUITests.swift
//  SandorTestAppUITests
//
//  Created by Balogh Sandor on 5/17/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import XCTest

class SandorTestAppUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearch() {
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testSearchZeroResult() {
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
        
        app.keys["A"].tap()
        for i in 0...Constants.cycleForZeroResultCount {
            app.keys["i"].tap()
            app.keys["o"].tap()
            app.keys["s"].tap()
        }
        
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Alert"].buttons["Ok"].tap()
        
    }
    
    func testMaxCharactersSearchBar() {
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
        
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        
        for i in 0...Constants.maxSearchCharacter {
            app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
        
        let okButton = app.alerts["Alert"].buttons["Ok"]
        okButton.tap()
        
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        for i in 0..<Constants.deleteActionsCount {
            deleteKey.tap()
        }
        
        moreKey.tap()
        
        for i in 0...Constants.deleteActionsCount {
            app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
        
        okButton.tap()
        
    }
    
    func testFirstResigneResponder() {
        
        let element = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.children(matching: .other).element.children(matching: .searchField).element.tap()
        element.children(matching: .table).element.tap()
        
    }
    
    func testCheckIsTableViewBecomesScrollableAndMemoryTest() {
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let doneButton = app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        doneButton.tap()
        app.searchFields.containing(.button, identifier:"Clear text").element.tap()
        for i in 0...Constants.searchesCount {
            doneButton.tap()
            app.searchFields.containing(.button, identifier:"Clear text").element.tap()
        }
        
        XCUIApplication().tables.children(matching: .cell).element(boundBy: 5).swipeUp()
        
    }
    
}


extension SandorTestAppUITests {
    struct Constants {
        static let cycleForZeroResultCount = 5
        static let maxSearchCharacter = 20
        static let deleteActionsCount = 2
        static let searchesCount = 18
    }
    
}

