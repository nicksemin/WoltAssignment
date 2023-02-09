//
//  RestaurantCellExtension.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 26.01.2023.
//

import UIKit
import CoreLocation

// MARK: - RestaurantListVC extensions

/// Necessary extension for custom UITableView controller to define number of cells and register the cells
extension RestuarantListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantsModel.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.restuarantCell) as! RestuarantCell
        let restuarant = RestaurantsModel.restaurants[indexPath.row]
        cell.set(restuarant: restuarant)
        
        // On callback
        cell.favTapCallback = {
            restuarant.toggleIsFav()
            cell.favButton.setImage(UIImage(named: restuarant.isFav ? "favTrue" : "favFalse"), for: .normal)
        }
        
        // Selection style to 'none' to disable highlighting of cells on tap
        cell.selectionStyle = .none
        
        return cell
    }
}

/// Extension to fetch coordinates using CoreLocation
extension RestuarantListVC : CLLocationManagerDelegate{
    func setUpLocationManegr() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        // coordinates.latitude = locValue.latitude; coordinates.longitude = locValue.longitude
        if coordinates.allowNewRequest() {
            coordinates = Coordinates(latitude: locValue.latitude, longitude: locValue.longitude)
        }
    }
}
