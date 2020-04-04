//
//  Swift.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import Foundation

protocol Downloadable: class {
    func didReceiveData(data: Any)
}
