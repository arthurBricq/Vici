//
//  ListTableViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    let headerHeight: CGFloat = 70.0
    let rowHeight: CGFloat = 200.0
    
    // MARK: - Variables
    
    // Those variables are to be set by the parent view controller. 
    var companies: [Company] = []
    var dataModel: [(sectionName: String, companies: [Company])] = []
    var showCompanyMethod: ((Company) -> Void)?
    var refreshData: (()->Void)?
    var addMoreRows: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
    }

    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        // It is the parent view controller in charge of refreshing the data
        self.refreshData?()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataModel.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel[section].companies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyTableViewCell
        let company = dataModel[indexPath.section].companies[indexPath.row]
        cell.setCompany(company: company)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = self.view.frame
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: headerHeight))
        view.backgroundColor = UIColor.clear
        
        let label = UILabel(frame: CGRect(x: 30, y: 12, width: 200, height: 50))
        label.text = dataModel[section].sectionName
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Discover"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // We must call the segue to the company page
        let company = dataModel[indexPath.section].companies[indexPath.row]
        showCompanyMethod?(company)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == dataModel.count-1 && indexPath.row == dataModel[indexPath.section].companies.count-1 {
            self.addMoreRows?()
        }
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
