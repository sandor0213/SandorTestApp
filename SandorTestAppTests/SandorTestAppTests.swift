//
//  SandorTestAppTests.swift
//  SandorTestAppTests
//
//  Created by Balogh Sandor on 5/17/19.
//  Copyright © 2019 AdlerBalogh. All rights reserved.
//

import XCTest
@testable import SandorTestApp

class SandorTestAppTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreateSearchResult() {
        let expectation = self.expectation(description: "exp")
        HTTPClient.searchForImage(searchPhrase: Constants.searchPhrase) { (json, status) in
            if status {
                expectation.fulfill()
                let searchResult = SearchResult().createSearchResult(searchedWord: Constants.searchPhrase, json: json!)
                XCTAssertNotNil(searchResult)
            }
        }
        self.wait(for: [expectation], timeout: Constants.timeInterval)
    }
    
    func testSaveSearchResultWithEmptyImageStringURL() {
        let searchResult = SearchResult()
        SearchResult().saveSearchResult(searchResult: searchResult)
        XCTAssertEqual("", searchResult.imageStringURL)
    }
    
    func testSaveSearchResult() {
        let searchResult = SearchResult()
        searchResult.imageStringURL = Constants.imageStringURL
        searchResult.searchedWord = Constants.searchPhraseNewYork
        SearchResult().saveSearchResult(searchResult: searchResult)
        XCTAssertEqual(Constants.imageStringURL, searchResult.imageStringURL)
        XCTAssertFalse(searchResult.imageStringURL.isEmpty)
    }
    
    func testGetSearchResults() {
        let searchResults = SearchResult.getSearchResults()
        XCTAssertNotNil(searchResults)
    }
    
    func testSearchForImage() {
        let expectation = self.expectation(description: "exp")
        HTTPClient.searchForImage(searchPhrase: Constants.searchPhrase) { (json, status) in
            expectation.fulfill()
            XCTAssertTrue(status)
            XCTAssertNotNil(status)
        }
        self.wait(for: [expectation], timeout: Constants.timeInterval)
    }
    
    func testReachability() {
        XCTAssertTrue(Reachability.isConnectedToNetwork())
    }
    
    func testGetURL() {
        XCTAssertEqual(Constants.requestString.getURL(), Constants.requestStringURL)
    }
    
    func testGetImageFromStringUrl() {
        XCTAssertNotNil(Constants.imageStringURL.getImageFromStringUrl())
        XCTAssertNil(Constants.searchPhrase.getImageFromStringUrl())
    }
    
    func testCheckMaxCharacters() {
        var testText = ""
        for i in 0..<Constants.maxSearchCharacter {
            testText += "1"
        }
        XCTAssertEqual(testText.checkMaxCharacters(), "")
        testText += "1"
        XCTAssertNotEqual(testText.checkMaxCharacters(), "")
    }
    
}


extension SandorTestAppTests {
    struct Constants {
        static let imageStringURL = "https://media.gettyimages.com/photos/kitten-sitting-on-dog-picture-id979081604?b=1&k=6&m=979081604&s=170x170&h=g9221AbrDyoyK92Dzj7_oXtYbf7juflNlQmf0SjXVnI="
        static let requestStringURL: URL = URL.init(string: "https://api.gettyimages.com/v3/search/images?page_size=1&phrase=New%20York")!
        static let searchPhraseNewYork = "New York"
        static let requestString = Configuration.restAPIURL + Constants.searchPhraseNewYork
        static let searchPhrase = "cat"
        static let notSearchPhrase = "dog"
        static let maxSearchCharacter = 20
        static let timeInterval = 1.7
    }
    
}
