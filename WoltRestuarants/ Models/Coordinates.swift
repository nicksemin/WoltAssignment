//
//  Coordinates.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 30.01.2023.
//

import Foundation

struct Coordinates {
    var latitude: Double
    var longitude: Double
    
    /// Cooldown is needed, otherwise API will turn down all requests
    /// Simulator does not changes location often, therefore, cooldown is not needed
    var cooldownTime: Double {
        #if targetEnvironment(simulator)
            return 0
        #else
            return 2
        #endif
    }
     
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    /// Static to make it available among all instances of Corridnates
    static var lastTime = Date()
    
    /// Setter that will be used
    func setLastUsedTime() {
        Coordinates.lastTime = Date()
    }
    
    // Simple check of coordinates are in 'initial state'
    func isZero() -> Bool {
        return self == Coordinates(latitude: 0.000000, longitude: 0.000000)
    }
    
    /// Method to check if cooldown time has passed to allow new request
    func allowNewRequest() -> Bool {
        return Coordinates.lastTime + cooldownTime < Date()
    }
    
    /// Overloaded equality operator
    static func ==(lhs: Coordinates, rhs: Coordinates) -> Bool {
        return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
    
    /// Overloaded inequality operators
    static func !=(lhs: Coordinates, rhs: Coordinates) -> Bool {
        return !(lhs == rhs)
    }
}
