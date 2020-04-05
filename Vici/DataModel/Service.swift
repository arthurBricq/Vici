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


enum CompanyCategory: Int {
    case restaurant = 0
    case epicerie = 1
    case fruitVegetables = 2
    case artisanat = 3
    case fleuriste = 4
    case mode = 5
    case boulangerie = 6
    case children = 7
    case alimentaire = 8
    case sport = 9
    case other = 10
}


/**
 Enumartion of all the different types of logo
 */
enum ServiceCategory: Int {
    case inStoreShoppin = 0  // = take away
    case onlineShopping = 1 // TODO LOGO
    case charity = 2
    case delivery = 3
    case mapPin = 4 // = point relai
    case other = 5
    
    func getString() -> String {
        switch self {
        case .charity: return "Charity"
        case .delivery: return "Delivery"
        case .mapPin: return "Point-relais"
        case .other: return "Others"
        case .inStoreShoppin: return "Direct Shopping"
        case .onlineShopping: return "Online Shopping"
        }
    }
    
    func getLogoName() -> String {
        switch self {
        case .charity: return "CharityLogo"
        case .delivery: return "DeliveryLogo"
        case .mapPin: return "MapPinLogo"
        case .other: return "ProfileLogo"
        case .inStoreShoppin: return "BasketLogo"
        case .onlineShopping: return "ProfileLogo" // todo
        }
    }
}

