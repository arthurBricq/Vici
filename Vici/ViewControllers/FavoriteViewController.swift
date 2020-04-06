//
//  FavoriteViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    var tableViewController: ListTableViewController?
    var companies: [Company] = []
    
    var isRefreshing: Bool = false
    var numberOfRequestInProcess: Int = 0
    var dataModelToSend: [(sectionName: String, companies: [Company])] = [(sectionName: "Favorites", [])]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add icon to navigation controller bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "AppLogo")
        imageView.image = image
        navigationItem.titleView = imageView
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllCompanies()
    }
    
    /// Called by TVC when a CompanyCell is tapped
    func showCompany(company: Company) {
        self.performSegue(withIdentifier: "FavoritesToCompany", sender: company)
    }
    
    /// Fetching function
    private func getAllCompanies() {
        // Try to get the data from the API
        let model = CompanyGetter(delegate: self)
        if let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            
            dataModelToSend = [(sectionName: "Favorites", [])]
            tableViewController?.dataModel = dataModelToSend
            tableViewController?.tableView.reloadData()
            
            // check each id in favorites
            for id in favorites {
                // check if it isn't already in the dataModel
                var isAlreadyInDataModel = false
                for company in dataModelToSend[0].companies {
                    if id == company.id {
                        isAlreadyInDataModel = true
                    }
                }
                // if it isn't, add it
                if !isAlreadyInDataModel {
                    model.downloadCompaniesWithFilter(id: id, code: 0)
                    numberOfRequestInProcess += 1
                }
            }
        }
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
        }
        if let dest = segue.destination as? CompanyViewController {
            dest.company = sender as? Company
        }
    }

}

extension FavoriteViewController: Downloadable {
    
    func didReceiveData(data: Any, code: Int) {
        if code == 0 {
            // request for only the three first ones
            numberOfRequestInProcess -= 1
            if let data = data as? Company {
                self.dataModelToSend[0].companies.append(data)
            }
            if numberOfRequestInProcess == 0 {
                self.sendDataToTVC()
            }
        }
    }
}
