//
//  Company.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

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
        if let services = self.services {
            var i: Int = 0
            for s in services {
                if let cat = ServiceCategory(rawValue: s.category) {
                    let name = cat.getLogoName()
                    if let image = UIImage(named: name) {
                        serviceImageViews?[i].image = image
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
        
        // Set the cover image background
        if let images = self.images {
            if let cover = images.first(where: { (image) -> Bool in
                return image.legend == "cover"
            }) {
                // Look if the image was loaded, and if so display it
                if let loaded = cover.loadedImage {
                    coverImageView?.image = UIImage(data: loaded)
                }
            }
        }
        
    }
    
    /**
     Call this function when wanting to display the images of this company.
     */
    func displayImages(coverImageView: UIImageView?, logoImageView: UIImageView?) {
        if let images = images {
            for image in images {
                if !image.isLoaded() {
                    print("need to load one image !")
                    // load the image
                    let url = URL(string: URLServices.baseURL + image.image)!
                    let imageLoader = ImageLoader()
                    imageLoader.downloadImage(from: url) { (loadedImage) in
                        if let loadedImage = loadedImage {
                            // 1. Save the loaded image
                            image.loadedImage = loadedImage.pngData()
                            
                            // 2. Display it
                            switch image.legend {
                            case "cover":
                                coverImageView?.image = loadedImage
                            case "logo":
                                logoImageView?.image = loadedImage
                            default:
                                print("Image with ")
                                break
                            }
                        } else {
                            print("DATA ERROR ON GETTING IMAGE")
                        }
                    }
                }
            }
        }
    }
    
}


