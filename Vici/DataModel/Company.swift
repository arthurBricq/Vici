//
//  Company.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

/**
 This class represents a company referenced in our database.
 It is the constructing elements of our different table views
 
 */
class Company: Codable {
    
    var name: String
    var description: String
    var location: [Float]?
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
                // todo: change this when server connection is done
                coverImageView?.image = UIImage(named: cover.image)
            }
        }
        
    }
    
}




