//
//  Network.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation




enum URLServices {
    static let baseURL: String = "http://vici.myftp.org"
    static let urlGetAllCompanies: String = "http://vici.myftp.org/api/v1/company/"
    static let urlGetFirst10Companies: String = "http://vici.myftp.org/api/v1/company/?limit=4"
    static let urlGetFirstNCompanies: String = "http://vici.myftp.org/api/v1/company/?limit="
    static let urlForAccount: String = "http://vici.myftp.org/login_app/"
    static let urlForCreateAccount: String = "http://vici.myftp.org/sign_up_app/"
    static let urlForComment: String = "http://vici.myftp.org/api/v1/comment/"
}

class Network {
    func getGetRequest(url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        return request
    }
    
    func getPostRequest(parameters: [String: Any], url: String) -> URLRequest {
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
