//
//  Swift.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation

protocol Downloadable: class {
    /**
    Callback method for when the data is done being loaded.
     The 'code' field is used to retrieve which result is coming from which request !
     We want to be able to handle several request at the same time. 
     */
    func didReceiveData(data: Any, code: Int)
}
