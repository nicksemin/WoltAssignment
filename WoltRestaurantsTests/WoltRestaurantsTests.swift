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
    let model = RestaurantsModel()

    func testRestaurant() throws {
        XCTAssert(sampleRestaurant.isFav == false)
        sampleRestaurant.toggleIsFav()
        XCTAssert(sampleRestaurant.isFav == true)
    }
    
    func testModelRequest() throws {
        model.fetchRestuarants(coordinates: Coordinates(latitude: 60.170187, longitude: 24.930599)) {
            XCTAssert(self.model.getRestaurants().count == 15)
        }
        
        model.fetchRestuarants(coordinates: Coordinates(latitude: 0.0000, longitude: 0.0000)) {
            XCTAssert(self.model.getRestaurants().count == 0)
        }
    }
    
    func testModelGetter() throws {
        var oldRestaurants = [Restaurant]()
        model.fetchRestuarants(coordinates: Coordinates(latitude: 60.170187, longitude: 24.930599)) {
            oldRestaurants = self.model.getRestaurants()
            XCTAssertFalse(!oldRestaurants.isEmpty)
            XCTAssert(oldRestaurants.count == 15)
        }
        
        model.fetchRestuarants(coordinates: Coordinates(latitude: 60.230187, longitude: 24.890599)) {
            let newRestaurants = self.model.getRestaurants()
            
            XCTAssertFalse(oldRestaurants[3].id == newRestaurants[3].id)
        }
    }
}
