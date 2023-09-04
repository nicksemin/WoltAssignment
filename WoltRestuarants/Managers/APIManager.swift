//
//  APIManager.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 04.09.2023.
//

import Foundation

class APIManager: APIManagerProtocol {
    func fetchRestuarants(coordinates: Coordinates, completion: @escaping ([Restaurant]) -> Void) {
        // better error handling (including enums for )
        //let (data, _) = try await URLSession.shared.data(from: endpointURL)
        
        
        guard let endpointURL = URL(string: "https://restaurant-api.wolt.com/v1/pages/restaurants?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)") else {
            return
        }
        
        URLSession.shared.dataTask(with: endpointURL) { data, response, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let restaurants = try self.decodeResponseData(data: data)
                    DispatchQueue.main.async {
                        completion(restaurants)
                    }
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    func decodeResponseData(data: Data) throws -> [Restaurant] {
        let result = try JSONDecoder().decode(Response.self, from: data)
        let slice = result.sections[1].items[0...14]
        let newRestaurants = restaurantFactory(from: slice)
    
        return newRestaurants
    }
    
    func restaurantFactory(from slice: ArraySlice<Item>) -> [Restaurant] {
        var newRestaurants = [Restaurant]()
        let items = Array(slice)
        
        items.forEach {
            let name =  $0.venue?.name ?? "Missing name"
            let description = $0.venue?.shortDescription ?? "Missing description"
            let id = $0.venue?.id ?? "Missing id"
            let imgUrl = $0.image.url
            newRestaurants.append(Restaurant(name: name, description: description, id: id, imgUrl: imgUrl))
        }
        
        return newRestaurants
    }
}
