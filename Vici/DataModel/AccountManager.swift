//
//  AccountManager.swift
//  Vici
//
//  Created by Marin on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

var accountManager = AccountManager()

class AccountManager {
    
    var username: String {
        get { return UserDefaults.standard.string(forKey: "username")! }
        set { UserDefaults.standard.set(newValue, forKey: "username") }
    }
    var emailAddress: String {
        get { return UserDefaults.standard.string(forKey: "emailAddress")! }
        set { UserDefaults.standard.set(newValue, forKey: "emailAddress") }
    }
    
    func sendPost() {
        
    }
    
}
