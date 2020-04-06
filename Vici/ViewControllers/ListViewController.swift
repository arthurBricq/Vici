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

    var distance: Int = 40
    // 11 corresponds to all
    var filterCategorySelected: Int = 11
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add icon to navigation controller bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "AppLogo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        // Get some companies 
        getAllCompanies()
        
        
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
        if segue.identifier == "FilterSegue" {
            let popoverVC = segue.destination as! FilterViewController
            popoverVC.distance = distance
            popoverVC.filterCategorySelected = filterCategorySelected
            popoverVC.modalPresentationStyle = .popover
            popoverVC.popoverPresentationController?.delegate = self
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

extension ListViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        if let filterVC = popoverPresentationController.presentedViewController as? FilterViewController {
            self.distance = filterVC.distance
            self.filterCategorySelected = filterVC.filterCategorySelected
        }
    }
    
}
