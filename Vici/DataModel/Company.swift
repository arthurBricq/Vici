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
    var id: Int
    var name: String
    var description: String
    var category: Int?
    var contacts: [String]?
    
    // var services: [Service]?
    var images: [Image]?
    
    init(id: Int, name: String, description: String, category: Int, contacts: [String]) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.contacts = contacts
    }
    
}
