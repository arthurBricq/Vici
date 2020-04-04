//
//  ListViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Try to get the data from the API
        let model = CompanyGetter(delegate: self)
        model.downloadCompanies(url: URLServices.urlTest)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: Downloadable { // implements our Downloadable protocol
    func didReceiveData(data: Any) {
        // The data model has been dowloaded at this point
        // Now, pass the data model to the Holidays table view controller
        print(data)
    }
}
