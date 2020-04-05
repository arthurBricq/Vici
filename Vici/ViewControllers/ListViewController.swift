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
    
    var isRefreshing: Bool = false
    var numberOfRequestInProcess: Int = 0
    var dataModelToSend: [(sectionName: String, companies: [Company])] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllCompanies()
        
        /*
        // Fake database
        
        let s1 = Service(category: ServiceCategory.charity.rawValue, description: "Service 1,")
        let s2 = Service(category: ServiceCategory.delivery.rawValue, description: "Service 2")
        let s3 = Service(category: ServiceCategory.charity.rawValue, description: "À votre service, service 3")
        let s4 = Service(category: ServiceCategory.delivery.rawValue, description: "Coucou")
        let s5 = Service(category: ServiceCategory.mapPin.rawValue, description: "C'est de la merde ces noms")
        let s6 = Service(category: ServiceCategory.other.rawValue, description: "Salut ca va oui et toi")
        
        let i1 = Image(legend: "cover", image: "vaches")
        let i2 = Image(legend: "cover", image: "velo1")
        let i3 = Image(legend: "cover", image: "biere1")
        
        let c1 = Company(name: "Agriculteur local", description: "Nous sommes une coopérative agricole locale et nous avons beaucoup d'artichaux à revendre !")
        c1.services = [s1, s2, s3]
        c1.images = [i1]
        
        let c2 = Company(name: "Velo Mec", description: "Nous sommes à votre disposition pour réparer vos vélos cassés.")
        
        c2.services = [s2, s4, s3]
        c2.images = [i2]
        
        let c3 = Company(name: "Brasserie", description: "Même en temps de crise, continuez de vous abbreuvez ! On vous livre les provisions.")
        c3.services = [s5, s6]
        c3.images = [i3]
        companies.append(c1)
        companies.append(c2)
        companies.append(c3)
        tableViewController?.companies = companies
        tableViewController?.tableView.reloadData()
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: -  functions
    
    /// Called by TVC when a CompanyCell is tapped
    func showCompany(company: Company) {
        self.performSegue(withIdentifier: "ListToCompany", sender: company)
    }
    
    /// Fetching function
    private func getAllCompanies() {
        // Try to get the data from the API
        let model = CompanyGetter(delegate: self)
        model.downloadNCompanies(n: 3, code: 0)
        model.downloadAllCompanies(code: 1)
        numberOfRequestInProcess += 2
    }
    
    /// Call this function when wanting to send the collected data to the children TableViewController
    private func sendDataToTVC() {
        DispatchQueue.main.async() {
            if self.isRefreshing {
                self.isRefreshing = false
                self.tableViewController?.refreshControl?.endRefreshing()
            }
            self.tableViewController?.dataModel = self.dataModelToSend
            self.tableViewController?.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ListTableViewController {
            self.tableViewController = dest
            dest.showCompanyMethod = { (company) in
                self.showCompany(company: company)
            }
            dest.refreshData = {
                self.isRefreshing = true
                self.getAllCompanies()
            }
            dest.addMoreRows = {
                // Let's download 5 more rows and update it
                let model = CompanyGetter(delegate: self)
                model.downloadNCompanies(n: 3, code: 2)
                self.numberOfRequestInProcess += 1
            }
        }
        if let dest = segue.destination as? CompanyViewController {
            dest.company = sender as? Company
        }
    }
}

extension ListViewController: Downloadable { // implements our Downloadable protocol
    func didReceiveData(data: Any, code: Int) {
        if code == 0 {
            // request for only the three first ones
            numberOfRequestInProcess -= 1
            if let data = data as? Initial {
                self.dataModelToSend.append((sectionName: "Discover", companies: data.objects))
            }
            if numberOfRequestInProcess == 0 {
                self.sendDataToTVC()
            }
        }
        
        if code == 1 {
            // Request for all the companies
            numberOfRequestInProcess -= 1
            if let data = data as? Initial {
                self.dataModelToSend.append((sectionName: "Around you", companies: data.objects))
            }
            if numberOfRequestInProcess == 0 {
                self.sendDataToTVC()
            }
        }
        
        if code == 2 {
            // Adding more rows
            // Request for all the companies
            numberOfRequestInProcess -= 1
            if let data = data as? Initial {
                self.dataModelToSend[1].companies.append(contentsOf: data.objects)
            }
            if numberOfRequestInProcess == 0 {
                self.sendDataToTVC()
            }
        }
        
        
    }
}
