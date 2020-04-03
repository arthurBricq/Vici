//
//  Company.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class Company {
    var name: String
    var category: Int
    var contacts: [String]
    var services: [Service]
    var helpDescription: String
    
    init(name: String, category: Int, contacts: [String], services: [Service], helpDescription: String) {
        self.name = name
        self.category = category
        self.contacts = contacts
        self.services = services
        self.helpDescription = helpDescription
    }
    
}
