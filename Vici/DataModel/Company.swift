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
    var id: Int?
    var name: String
    var description: String
    var category: Int?
    var contacts: [String]?
    var help: String? 
    
    // var services: [Service]?
    var images: [Image]?
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
}
