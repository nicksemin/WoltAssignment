//
//  UIImageExtension.swift
//  WoltRestuarants
//
//  Created by Nick Semin on 26.01.2023.
//

import UIKit

// MARK: - UIImage extension

/// An extension to work with images that are fetched by URL
/// While an image is being loaded a placeholder will be shown
extension UIImageView {
    public func imageFromURL(urlString: String, PlaceHolderImage:UIImage) {
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
