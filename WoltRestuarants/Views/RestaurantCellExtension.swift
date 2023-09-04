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
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.restuarantCell) as! RestuarantCell
        let restuarant = restaurants[indexPath.row]
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
