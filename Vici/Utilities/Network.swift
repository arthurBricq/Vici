//
//  Network.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation


enum URLServices {
    // change to your PHP script in your own server.
    static let urlTest: String = "http://192.168.1.40:8000/api/v1/company/"
    static let urlForAccount: String = "<ip>:8000/login_app/"
}


class Network {
    
    func sendGetRequest(url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        return request
    }
    
    func sendPostRequest(parameters: [String: Any], url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return request
    }
    
    func response(request: URLRequest, completionBlock: @escaping (Data) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {   // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            guard (200 ... 299) ~= response.statusCode else { //check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            // data will be available for other models that implements the block
            completionBlock(data);
        }
        task.resume()
     }
}
