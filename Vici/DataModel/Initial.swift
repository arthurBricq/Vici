//
//  Initial.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation

/**
 This class is used to represent the JSON data fetched from the server
 */
struct Initial: Codable {
    var meta: Meta
    var objects: [Company]
    
    init(meta: Meta, objects: [Company]) {
        self.meta = meta
        self.objects = objects
    }
}
