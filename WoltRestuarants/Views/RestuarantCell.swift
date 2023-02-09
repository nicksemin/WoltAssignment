//
//  RestuarantCell.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 17.01.2023.
//

import UIKit

class RestuarantCell: UITableViewCell {
    var favTapCallback: () -> () = { }
    var restuarantImage = UIImageView()
    
    var restuarantName = UILabel()
    var restuarantDescription = UILabel()
    var favButton: UIButton = {
        var btn = UIButton()
        btn.tintColor = .gray
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(restuarantImage)
        addSubview(restuarantName)
        addSubview(restuarantDescription)
        
        
        favButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        contentView.addSubview(favButton)
        
        configureNameLabel()
        configureDescriptionLabel()
        
        setImageConstraints()
        setNameConstraints()
        setDescriptionConstraints()
        setButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton(_ sender: UIButton ) {
        favTapCallback()
    }
    
    // MARK: - Setting constraints
    func set(restuarant: Restaurant) {
        restuarantName.text = restuarant.name
        restuarantDescription.text = restuarant.description
        favButton.setImage(UIImage(named: restuarant.isFav ? "favTrue" : "favFalse"), for: .normal)
        restuarantImage.imageFromURL(urlString:  restuarant.imgUrl, PlaceHolderImage: UIImage.init(named: "imgPlaceholder")!)
    }
    
    func configureNameLabel() {
        restuarantName.numberOfLines = 0
        restuarantName.adjustsFontSizeToFitWidth = true
        restuarantName.font = UIFont.boldSystemFont(ofSize: 13.0)
    }
    
    func configureDescriptionLabel() {
        restuarantDescription.numberOfLines = 0
        restuarantDescription.adjustsFontSizeToFitWidth = true
        restuarantDescription.font = UIFont.italicSystemFont(ofSize: 10.0)
    }
    
    func setNameConstraints() {
        restuarantName.translatesAutoresizingMaskIntoConstraints = false
        restuarantName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        restuarantName.leadingAnchor.constraint(equalTo: restuarantImage.trailingAnchor, constant: 12).isActive = true
        restuarantName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
    }
    
    func setDescriptionConstraints() {
        restuarantDescription.translatesAutoresizingMaskIntoConstraints = false
        restuarantDescription.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        restuarantDescription.leadingAnchor.constraint(equalTo: restuarantImage.trailingAnchor, constant: 12).isActive = true
        restuarantDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        restuarantDescription.topAnchor.constraint(equalTo: restuarantName.bottomAnchor, constant: 0).isActive = true
    }
    
    func setImageConstraints() {
        restuarantImage.translatesAutoresizingMaskIntoConstraints = false
        restuarantImage.layer.cornerRadius = 10
        restuarantImage.clipsToBounds = true
        
        restuarantImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        restuarantImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        restuarantImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        restuarantImage.widthAnchor.constraint(equalTo: restuarantImage.heightAnchor, multiplier: 4/3).isActive = true
    }

    func setButtonConstraints() {
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        favButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

