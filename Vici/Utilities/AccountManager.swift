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
    
    let networkModel = Network()
    
    private var username: String? {
        get { return UserDefaults.standard.string(forKey: "username") }
        set { UserDefaults.standard.set(newValue, forKey: "username") }
    }
    private var emailAddress: String? {
        get { return UserDefaults.standard.string(forKey: "emailAddress") }
        set { UserDefaults.standard.set(newValue, forKey: "emailAddress") }
    }
    private var apiKey: String? {
        get { return UserDefaults.standard.string(forKey: "apiKey") }
        set { UserDefaults.standard.set(newValue, forKey: "apiKey") }
    }
    
    func sendPostToConnect(username: String, password: String, completion: @escaping (Bool) -> Void) {
        
        let parameters: [String: Any] = ["username": username, "password": password]
        let request = Network().getPostRequest(parameters: parameters, url: URLServices.urlForAccount)
        networkModel.response(request: request) { (data) in
            print(data.description)
            do {
                let model = try JSONDecoder().decode(JSONFeedback?.self, from: data) as JSONFeedback?
                let success = model!.success
                if (success) {
                    UserDefaults.standard.set(true, forKey: "hasAccount")
                    self.username = username
                    print("KEY: ", model!.apiKey)
                    self.apiKey = model!.apiKey
                }
                completion(success)
            } catch {
                print(error)
                completion(false)
            }
            // work !!
        }
        
        let success = true
        if (success) {
            UserDefaults.standard.set(true, forKey: "hasAccount")
            self.username = username
        }
    }
    
    func sendPostToCreate(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = ["username": username, "email": email, "password": password]
        let request = Network().getPostRequest(parameters: parameters, url: URLServices.urlForCreateAccount)
        networkModel.response(request: request) { (data) in
            do {
                let model = try JSONDecoder().decode(JSONFeedback?.self, from: data) as JSONFeedback?
                let success = model!.success
                if (success) {
                    UserDefaults.standard.set(true, forKey: "hasAccount")
                    self.username = username
                    self.emailAddress = email
                    print("KEY: ", model!.apiKey)
                    self.apiKey = model!.apiKey
                }
                completion(success)
            } catch {
                print(error)
                 completion(false)
            }
        }
    }
    
    func sendPostToComment(companyId: Int, message: String, stars: Int) {
        let c = "/api/v1/company/" + String(companyId) + "/"
        let parameters: [String: Any] = ["company": c, "message": message, "stars": stars, "user": "/api/v1/user/1/"]
        let request = Network().getPostRequest(parameters: parameters, url: URLServices.urlForComment)
        networkModel.response(request: request) { (data) in
            // 
        }
        
    }
    
}
