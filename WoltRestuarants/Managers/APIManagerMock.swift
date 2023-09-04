//
//  APIManagerMock.swift
//  WoltRestaurantsTests
//
//  Created by Nick Semin on 04.09.2023.
//

import Foundation

class APIManagerMock: APIManagerProtocol {
    enum SampleError: Error {
        case Error
    }
    func decodeResponseData(data: Data) throws -> [Restaurant] {
        if data.isEmpty {
            throw SampleError.Error
        } else {
            return [Restaurant(name: "Sample name", description: "Description", id: "fvbhytfvbhyf", imgUrl: "file:///soempath"),
                    Restaurant(name: "Sample name2", description: "Description2", id: "fvbhytfvb353yf", imgUrl: "file:///soempath")]
        }
    }
    
    func restaurantFactory(from slice: ArraySlice<Item>) -> [Restaurant] {
        return [Restaurant(name: "Sample name", description: "Description", id: "fvbhytfvbhyf", imgUrl: "file:///soempath"),
                 Restaurant(name: "Sample name2", description: "Description2", id: "fvbhytfvb353yf", imgUrl: "file:///soempath")]
    }
    
    func fetchRestaurants(coordinates: Coordinates, completion: @escaping ([Restaurant]) -> Void) {
        completion(
            [Restaurant(name: "Sample name", description: "Description", id: "fvbhytfvbhyf", imgUrl: "file:///soempath"),
            Restaurant(name: "Sample name2", description: "Description2", id: "fvbhytfvb353yf", imgUrl: "file:///soempath")]
        )
    }
}
