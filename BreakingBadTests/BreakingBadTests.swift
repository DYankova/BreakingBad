//
//  BreakingBadTests.swift
//  BreakingBadTests
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import XCTest
@testable import BreakingBad

class BreakingBadTests: XCTestCase {

    var networkingManager: NetworkingManager!
    
    override func setUpWithError() throws {
        super.setUp()
        networkingManager = NetworkingManager.shared
    }

    override func tearDownWithError() throws {
        networkingManager = nil
        super.tearDown()
    }

    
    func testDataContainsValidItems() throws {
        networkingManager.downloadCharacters() { result in
            switch result {
            case .success(let characters):
                XCTAssertGreaterThan(characters.count, 0)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    
    func testSearchBarReturnsCorrectItems() throws {
        networkingManager.downloadCharacters() { result in
            switch result {
            case .success(let characters):
                let searchText = "Walt"
                let filteredCharacters = characters.filter { $0.name.contains(searchText) }
                XCTAssertEqual(filteredCharacters.count, 2)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

}
