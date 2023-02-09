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
        self.model = RestaurantsModel()
        self.restaurants = model.getRestaurants()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: RestaurantsModel
    var restaurants: [Restaurant]
    
    let locationManager = CLLocationManager()
    
    var newRequestCooldown = Date()
    
    /// Computed property to retry fetch request if the
    var coordinates: Coordinates = Coordinates(latitude: 0.000000, longitude: 0.000000) {
        didSet {
            if coordinates != oldValue  {
                model.fetchRestuarants(coordinates: coordinates) {
                    self.tableView.reloadData()
                }
                newRequestCooldown = Date()
            }
        }
    }
    
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
        
        model.fetchRestuarants(coordinates: coordinates) {
            self.tableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
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
