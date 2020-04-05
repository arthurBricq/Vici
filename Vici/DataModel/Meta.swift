//
//  Meta.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation


/**
 This class is used to contain some basic information about the JSON data fetched from the server
 */
class Meta: Codable {
    var limit: Int
    var next: String?
    var offset: Int
    var previous: String?
    var totalCount: Int
    
    init(limit: Int, offset: Int, totalCount: Int) {
        self.limit = limit
        self.offset = offset
        self.totalCount = totalCount
    }
    
}
