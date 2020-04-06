//
//  Initial.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation

// Those strucs are used to decode JSON files sent by Django.
// They are the roots of the JSON files and act as the top part of the cascade

/**
 Top hierarchy JSON data for when fetching **companies**
 */
struct Initial: Codable {
    var meta: Meta
    var objects: [Company]
    
    init(meta: Meta, objects: [Company]) {
        self.meta = meta
        self.objects = objects
    }
}

/**
Top hierarchy JSON data for when  **connecting to a user profile**
*/
struct InitialConnection: Codable {
    var feedback: JSONFeedback
    
    init(meta: Meta, feedback: JSONFeedback) {
        self.feedback = feedback
    }
}


