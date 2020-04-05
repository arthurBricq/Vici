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
    
    var username: String? {
        get { return UserDefaults.standard.string(forKey: "username") }
        set { UserDefaults.standard.set(newValue, forKey: "username") }
    }
    var emailAddress: String? {
        get { return UserDefaults.standard.string(forKey: "emailAddress") }
        set { UserDefaults.standard.set(newValue, forKey: "emailAddress") }
    }
    var apiKey: String? {
        get { return UserDefaults.standard.string(forKey: "apiKey") }
        set { UserDefaults.standard.set(newValue, forKey: "apiKey") }
    }
    
    func sendPostToConnect(username: String, password: String) -> Bool {
        let parameters: [String: Any] = ["username": username, "password": password]
        //let request = Network().sendPostRequest(parameters: parameters, url: URLServices.urlForAccount)
        
        let success = true
        
        if (success) {
            UserDefaults.standard.set(true, forKey: "hasAccount")
            self.username = username
        }
        
        return success
    }
    
    func sentPostToCreate(username: String, email: String, password: String) -> Bool {
        let parameters: [String: Any] = ["username": username, "email": email, "password": password]
        //let request = Network().sendPostRequest(parameters: parameters, url: <#T##String#>)
        
        let success = true
        if (success) {
            UserDefaults.standard.set(true, forKey: "hasAccount")
            self.username = username
            self.emailAddress = email
        }
        
        return success
    }
    
}
