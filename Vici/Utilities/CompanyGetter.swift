//
//  CompanyDecoder.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation

/**
 This class is used to do the fecthing to the database.
 */
class CompanyGetter {
    
    weak var delegate: Downloadable?
    let networkModel = Network()
    
    init(delegate: Downloadable) {
        self.delegate = delegate
    }
    
    func downloadCompanies(url: String) {
        let request = networkModel.sendGetRequest(url: url)
        networkModel.response(request: request) { (data) in
            print(data.description)
            let model = try! JSONDecoder().decode(Initial?.self, from: data) as Initial?
            self.delegate?.didReceiveData(data: model! as Initial)
        }
    }
    
    
}
