//
//  Company.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

var cache = NSCache<NSString, UIImage>()

/**
 This class represents a company referenced in our database. It is the constructing elements of our different table views.
 
 # Note about loading the pictures
 
 The pictures are impossible to load directly, and when loaded they need to imediatly appear in an UIImageView of a view controller. Gestion of loading pictures will be quite difficult,
 
 */
class Company: Codable {

    var name: String
    var description: String
    var location: String?
    var category: Int?
    var id: Int?
    var openingHours: String?
    var adress: [String]?
    var contacts: [String]?
    var helpMessage: String?
    
    var services: [Service]?
    var images: [Image]?
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    // MARK: - Helper functions
    
    /**
        This method can be called to fill the screen of any ViewController with this company.
     
     Used by
     - ListTableViewController
     - CompanyViewController
     */
    func setScreenWithSelf(titleLabel: UILabel?, bodyLabel: UILabel?, coverImageView: UIImageView?, logoImageView: UIImageView?, serviceImageViews: [UIImageView]?) {
        
        titleLabel?.text = self.name
        bodyLabel?.text = self.description
        
        // Set the icons on the main page
        DispatchQueue.global(qos: .background).async {
            
            if let services = self.services {
                var i: Int = 0
                for s in services {
                    if let cat = ServiceCategory(rawValue: s.category) {
                        let name = cat.getLogoName()
                        if let image = UIImage(named: name) {
                            DispatchQueue.main.async {
                                serviceImageViews?[i].image = image
                            }
                        } else {
                            print("LOGO NAME ERROR WITH : ", name)
                        }
                        i = i + 1
                        if i > (serviceImageViews?.count ?? 0) {
                            break
                        }
                    }
                }
            }
        }
        
    }
    
    /**
     Call this function when wanting to display the images of this company. If the image wasn't loaded so far, then it will load it from the server. Else, it will simply reuse it as the image will be on the cache.
     */
    func displayImages(coverImageView: UIImageView?, logoImageView: UIImageView?) {
        DispatchQueue.global(qos: .userInitiated).async  {
            if let images = self.images {
                if images.isEmpty {
                    DispatchQueue.main.async {
                        coverImageView?.image = nil
                        logoImageView?.image = nil
                    }
                }
                else {
                    for image in images {
                        if let loadedImage = cache.object(forKey: String(image.id) as NSString) {
                            // The image is in the cache, so let's simply reuse it
                            DispatchQueue.main.async() {
                                switch image.legend {
                                case "cover": coverImageView?.image = loadedImage
                                case "logo": logoImageView?.image = loadedImage
                                default: print("TODO: image to illustrate the company ")
                                }
                            }
                        }
                        else {
                            // We need to load the image, since it is not in the cache 
                            let url = URL(string: URLServices.baseURL + image.image)!
                            ImageLoader().downloadImage(from: url) { (loadedImage) in
                                if let loadedImage = loadedImage {
                                    // Save the image on the cache and display it on the table view
                                    cache.setObject(loadedImage, forKey: String(image.id) as NSString)
                                    DispatchQueue.main.async {
                                        switch image.legend {
                                        case "cover": coverImageView?.image = loadedImage
                                        case "logo": logoImageView?.image = loadedImage
                                        default: print("TODO: image to illustrate the company ")
                                        }
                                    }
                                }
                                else {
                                    print("DATA ERROR ON GETTING IMAGE")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


