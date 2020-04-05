//
//  CompanyDecoder.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation

/**
 This class is used to fetch from the database the companies. It is therefore one of the most important class of the project, as it will perform the synchronisation and the population of the tableviews
 */
class CompanyGetter {
    
    weak var delegate: Downloadable?
    let networkModel = Network()
    
    init(delegate: Downloadable) {
        self.delegate = delegate
    }
    
    func downloadAllCompanies(code: Int) {
        let request = networkModel.getGetRequest(url: URLServices.urlGetAllCompanies)
        networkModel.response(request: request) { (data) in
            print(data.description)
            do {
                let model = try JSONDecoder().decode(Initial?.self, from: data) as Initial?
                self.delegate?.didReceiveData(data: model! as Initial, code: code)
            } catch {
                print(error)
            }
        }
    }
    
    func downloadNCompanies(n: Int, code: Int) {
        let request = networkModel.getGetRequest(url: URLServices.urlGetFirstNCompanies + String(n))
        networkModel.response(request: request) { (data) in
            print(data.description)
            do {
                let model = try JSONDecoder().decode(Initial?.self, from: data) as Initial?
                self.delegate?.didReceiveData(data: model! as Initial, code: code)
            } catch {
                print(error)
            }
        }
    }
    
    
    
}
