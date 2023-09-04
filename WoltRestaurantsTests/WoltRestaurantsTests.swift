//
//  WoltRestaurantsTests.swift
//  WoltRestaurantsTests
//
//  Created by Nick Semin on 29.01.2023.
//

import XCTest
@testable import WoltRestuarants

final class WoltRestaurantsTests: XCTestCase {
    
    let sampleRestaurant = Restaurant(name: "Sample Name", description: "A sample description", id: UUID().uuidString, imgUrl: "http://www.google.com")
    let mock = APIManagerMock()
    let coordinates = Coordinates(latitude: 60.000, longitude: 42.000)

    func testRestaurant() throws {
        XCTAssert(sampleRestaurant.isFav == false)
        sampleRestaurant.toggleIsFav()
        XCTAssert(sampleRestaurant.isFav == true)
    }
    
    // TODO: test other manager's methods
    
    func testManagerFetch() throws {
        mock.fetchRestaurants(coordinates: coordinates) { restaurants in
            XCTAssert(restaurants.count == 2)
        }
    }
}
