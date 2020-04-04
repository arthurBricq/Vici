//
//  ListViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var tableViewController: ListTableViewController?
    var companies: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Try to get the data from the API
        /*
        let model = CompanyGetter(delegate: self)
        model.downloadCompanies(url: URLServices.urlTest)
         */
        
        companies.append(Company(name: "Epicerie", description: "Petite épicerie de quartier à votre panier."))
        companies.append(Company(name: "Reparateur de vélo", description: "Nous sommes à votre disposition pour réparer vos vélos cassés."))
        tableViewController?.companies = companies
        tableViewController?.tableView.reloadData()
    }
    
    func showCompany(company: Company) {
        self.performSegue(withIdentifier: "ListToCompany", sender: company)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ListTableViewController {
            self.tableViewController = dest
            dest.showCompanyMethod = { (company) in
                self.showCompany(company: company)
            }
        }
        if let dest = segue.destination as? CompanyTableViewController {
            dest.company = sender as? Company
        }
    }
}

extension ListViewController: Downloadable { // implements our Downloadable protocol
    func didReceiveData(data: Any) {
        // The data model has been dowloaded at this point
        // Now, pass the data model to the Holidays table view controller
        if let data = data as? Initial {
           print(data)
        }
        
    }
}
