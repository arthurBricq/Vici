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
    
}




