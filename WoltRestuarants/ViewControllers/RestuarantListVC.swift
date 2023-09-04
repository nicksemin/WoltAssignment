//
//  RestuarantListVC.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 17.01.2023.
//

import UIKit
import CoreLocation

class RestuarantListVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var apiManager = APIManager()
    var restaurants = [Restaurant]()
    
    let locationManager = CLLocationManager()
    
    struct Cells {
        static let restuarantCell = "RestuarantCell"
    }
    
    var tableView = UITableView()
    var activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Venues nearby"
        configureTableView()
        setUpLocationManegr()
        
        tableView.backgroundView = activityIndicatorView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if restaurants.isEmpty {
            activityIndicatorView.startAnimating()
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 130
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.register(RestuarantCell.self, forCellReuseIdentifier: Cells.restuarantCell)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

/// Extension to fetch coordinates using CoreLocation
extension RestuarantListVC : CLLocationManagerDelegate {
    func setUpLocationManegr() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        // coordinates.latitude = locValue.latitude; coordinates.longitude = locValue.longitude
        apiManager.fetchRestuarants(coordinates: Coordinates(latitude: locValue.latitude, longitude: locValue.longitude)) { [weak self] restaurants in
            self?.restaurants = restaurants
            self?.tableView.reloadData()
            self?.activityIndicatorView.stopAnimating()
        }
    }
}
