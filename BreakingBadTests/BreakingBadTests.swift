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
    
    
    override func setUp() {
        super.setUp()
        networkingManager = NetworkingManager.shared
    }
    
    
    override func tearDown() {
        networkingManager = nil
        super.tearDown()
    }

    
    func testDataContainsValidItems() throws {
        networkingManager.downloadCharacters() { result in
            switch result {
            case .success(let characters):
                XCTAssertGreaterThan(characters.count, 0)
                XCTAssertEqual(characters.first?.name, "Walter White")
                XCTAssertEqual(characters.first?.nickname, "Heisenberg")
                XCTAssertEqual(characters.first?.appearance, [1, 2, 3, 4, 5])
                XCTAssertEqual(characters.first?.status, "Presumed Dead")
                XCTAssertEqual(characters.first?.occupation, ["High School Chemistry Teacher", "Meth King Pin"])
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
