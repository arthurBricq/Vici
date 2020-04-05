//
//  Image.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation
import UIKit

/**
 This class represents one image fetched from the database
 */
class Image: Codable {
    var legend: String
    // Image URL
    var image: String
    var id: Int
    
    init(legend: String, image: String, id: Int) {
        self.legend = legend
        self.image = image
        self.id = id 
    }
    
    public func isLoaded() -> Bool {
        return id != nil
    }
    
}


