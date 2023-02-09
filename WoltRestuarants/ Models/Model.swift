//
//  Model.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 26.01.2023.
//

import Foundation

class RestaurantsModel {
    static public var restaurants = [Restaurant]()
    
    func getRestaurants() -> [Restaurant] {
        return RestaurantsModel.restaurants
    }
    
    /// Factory method that will create 15 restaurants from array slice of 15 items
    func restaurantFactory(from slice: ArraySlice<Item>) -> [Restaurant] {
        var newRestaurants = [Restaurant]()
        let items = Array(slice)
        
        for item in items {
            let name =  item.venue?.name ?? "Missing name"
            let description = item.venue?.shortDescription ?? "Missing description"
            let id = item.venue?.id ?? "Missing id"
            let imgUrl = item.image.url
            newRestaurants.append(Restaurant(name: name, description: description, id: id, imgUrl: imgUrl))
        }
        
        return newRestaurants
    }
    
    func fetchRestuarants(coordinates: Coordinates , completionCallback: @escaping () -> ()) {
        guard let url = URL(string: "https://restaurant-api.wolt.com/v1/pages/restaurants?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)") else {
            return
        }
        
        // No need to load data if user's locartion has not been changed yets
        if coordinates.isZero() { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        let slice = result.sections[1].items[0...14]
                        let newRestaurants = self.restaurantFactory(from: slice)
                        
                        RestaurantsModel.restaurants = [Restaurant]()
                        RestaurantsModel.restaurants = newRestaurants
                        // Execute the callback when fetching is completed
                        completionCallback()
                        // Update last time a request was made
                        coordinates.setLastUsedTime()
                    }
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }.resume()
    }
}
