//
//  JSONFeedback.swift
//  Vici
//
//  Created by Arthur BRICQ on 05/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation

// Is a standard response sent by the server to say something like "it worked well!" or something like "it didn't I'm sorry"
class JSONFeedback: Codable {
    var success: Bool
    var errorMessage: String?
    var apiKey: String?
}
