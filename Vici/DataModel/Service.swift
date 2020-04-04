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
    var category: Int
    var description: String
    
    init(category: Int, description: String) {
        self.description = description
        self.category = category
    }
    
}


/**
 Enumartion of all the different types of logo
 */
enum ServiceCategory: Int {
    case artisanat
    case basket
    case charity
    case delivery
    case house
    case mapPin
    case restaurant
    case sport
    case tools
    case other
    
    func getString() -> String {
        switch self {
        case .artisanat: return "Artisanat"
        case .basket: return "Shopping"
        case .charity: return "Charity"
        case .delivery: return "Delivery"
        case .house: return "House"
        case .mapPin: return "Point-relais"
        case .restaurant: return "Restaurant"
        case .sport: return "Sport"
        case .tools: return "Tools"
        case .other: return "Others"
        }
    }
    
    func getLogoName() -> String {
        switch self {
        case .artisanat: return "ArtisanatLogo"
        case .basket: return "BasketLogo"
        case .charity: return "CharityLogo"
        case .delivery: return "DeliveryLogo"
        case .house: return "HouseLogo"
        case .mapPin: return "MapPinLogo"
        case .restaurant: return "RestaurantLogo"
        case .sport: return "SportLogo"
        case .tools: return "ToolsLogo"
        case .other: return "ProfileLogo"
        }
    }
}

