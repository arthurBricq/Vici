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
    var loadedImage: Data?
    
    
    init(legend: String, image: String) {
        self.legend = legend
        self.image = image
    }
    
    public func isLoaded() -> Bool {
        return loadedImage != nil 
    }
    
}


