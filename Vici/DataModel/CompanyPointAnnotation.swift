//
//  CompanyPointAnnotation.swift
//  Vici
//
//  Created by Marin on 05/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CompanyPointAnnotation: MKPointAnnotation {
    
    var companyPos: Int
    
    init(pos: Int) {
        companyPos = pos
        
        super.init()
    }
}
