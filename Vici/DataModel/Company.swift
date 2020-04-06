//
//  Company.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit
import CoreLocation


class StringData: Codable {
    var data: String
}

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
    var street: String?
    var city: String?
    var email: String?
    var phone: String?
    var helpMessage: String?
    
    var services: [Service]?
    var images: [Image]?
    var comments: [StringData]? 
    
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
    func setScreenWithSelf(titleLabel: UILabel?, bodyLabel: UILabel?, serviceImageViews: [UIImageView]?, categoryLabel: UILabel? = nil) {
        // Set the labels 
        titleLabel?.text = self.name
        bodyLabel?.text = self.description
        categoryLabel?.text = CompanyCategory(rawValue: category!)?.getString()
        
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
        
        
    }
    
    /**
     Call this function when wanting to display the images of this company. If the image wasn't loaded so far, then it will load it from the server.
     Else, it will simply reuse it as the image will be on the cache.
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
                                default: print("Other image was loaded")
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
                                        default: print("Other image was loaded")
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
    
    func getLocationForMap() -> CLLocationCoordinate2D {
        let splitted = self.location!.split(separator: Character(" "))
        let max = splitted.count
        var lonStr = String(splitted[max-2])
        lonStr.removeFirst()
        var latStr = String(splitted[max-1])
        latStr.removeLast()
        print(latStr, lonStr)
        let lat = Double(latStr)!
        let lon = Double(lonStr)!
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    public func isFavorite() -> Bool {
        if let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            return favorites.contains(self.id!)
        }
        return false
    }
    
    public func changeFavoriteSetting() {
        if let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            if let index = favorites.firstIndex(where: { (id) -> Bool in id == self.id! }) {
                // It means the favorite needs to be removed
                var tmp = favorites
                tmp.remove(at: index)
                UserDefaults.standard.set(tmp, forKey: "favorites")
            }
            else {
                // It means we need to add in the favorites
                var tmp = favorites
                tmp.append(self.id!)
                UserDefaults.standard.set(tmp, forKey: "favorites")
            }
        }
    }
}


