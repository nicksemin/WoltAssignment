//
//  APIManagerProtocol.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 04.09.2023.
//

import Foundation

protocol APIManagerProtocol {
    func fetchRestuarants(coordinates: Coordinates, completion: @escaping ([Restaurant]) -> Void)
    
    func decodeResponseData(data: Data) throws -> [Restaurant]
    
    func restaurantFactory(from slice: ArraySlice<Item>) -> [Restaurant]
}
