//
//  CoordinatesTest.swift
//  WoltRestaurantsTests
//
//  Created by Nick Semin on 30.01.2023.
//

import XCTest
@testable import WoltRestuarants

final class CoordinatesTest: XCTestCase {
    
    var coordinates0 = Coordinates(latitude: 0.000_000, longitude: 0.000_000)
    var coordinates1 = Coordinates(latitude: 60.000_000, longitude: 25.000_000)
    var coordinates2 = Coordinates(latitude: 61.000_000, longitude: 24.000_000)
    
    // Test if overloaded operators work
    func testOperators() throws {
        XCTAssertFalse(coordinates1 == coordinates2)
        XCTAssertTrue(coordinates1 != coordinates2)
    }
    
    func testIsZero() throws {
        XCTAssertFalse(coordinates1.isZero())
        XCTAssertTrue(coordinates0.isZero())
    }
    
    func testCooldown() {
        XCTAssert(coordinates0.cooldownTime == coordinates1.cooldownTime)
        sleep(2)
        XCTAssert(coordinates1.allowNewRequest() == coordinates2.allowNewRequest())
    }
}
