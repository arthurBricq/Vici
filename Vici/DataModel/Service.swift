//
//  Service.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class Service {
    var name: String
    var description: String
    var logoId: String
    var prix: Int?
    
    init(name: String, description: String, logoId: String, prix: Int?) {
        self.name = name
        self.description = description
        self.logoId = logoId
        self.prix = prix
    }
}

