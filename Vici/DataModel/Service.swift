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
    case restaurant = 0 // ok
    case epicerie = 1 // todo
    case fruitVegetables = 2 // todo
    case artisanat = 3 // todo
    case fleuriste = 4 // todo
    case mode = 5 // todo
    case boulangerie = 6 // todo
    case children = 7 // todo
    case alimentaire = 8 // todo
    case sport = 9 // todo
    case other = 10 // todo
    
    func getString() -> String {
        switch self {
        case .restaurant:
            return "Restaurant"
        case .epicerie:
            return "Grocery"
        case .fruitVegetables:
            return "Fruit & Veg"
        case .artisanat:
            return "Craft"
        case .fleuriste:
            return "Florist"
        case .mode:
            return "Fashion"
        case .boulangerie:
            return "Baker"
        case .children:
            return "Children"
        case .alimentaire:
            return "Food"
        case .sport:
            return "Sport"
        case .other:
            return "Other"
        }
    }
    
    func getImage() -> UIImage {
        switch self {
        case .restaurant:
            return UIImage(named: "restaurant")!
        case .epicerie:
            return UIImage(named: "HouseLogo")!
        case .fruitVegetables:
            return UIImage(named: "vegetables")!
        case .artisanat:
            return UIImage(named: "artisanat")!
        case .fleuriste:
            return UIImage(named: "fluriste")!
        case .mode:
            return UIImage(named: "mode")!
        case .boulangerie:
            return UIImage(named: "boulangerie")!
        case .children:
            return UIImage(named: "children")!
        case .alimentaire:
            return UIImage(named: "alimentaire")!
        case .sport:
            return UIImage(named: "sport")!
        case .other:
            return UIImage(systemName: "questionmark.circle")!
        }
    }
    
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

