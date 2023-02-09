//
//  Restuarant.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 17.01.2023.
//

import Foundation

class Restaurant {
    
    init(name: String, description: String, id: String, imgUrl: String) {
        self.name = name
        self.description = description
        self.id = id
        self.imgUrl = imgUrl
        self.isFav = UserDefaults.standard.object(forKey: id) as? Bool ?? false
    }
    
    let name: String
    let description: String
    let id: String
    let imgUrl: String
    var isFav: Bool
    
    func toggleIsFav() {
        isFav.toggle()
        UserDefaults.standard.set(isFav, forKey: id)
    }
}
