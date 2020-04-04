//
//  Service.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

/**
This class is one service of a company
 */
class Service: Codable {
    var name: String
    var description: String
    var logo: String
    var price: Int?
    
    init(name: String, description: String, logo: String, price: Int) {
        self.name = name
        self.description = description
        self.logo = logo
        self.price = price
    }
}

