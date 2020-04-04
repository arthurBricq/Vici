//
//  ListTableViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    let headerHeight: CGFloat = 70.0
    let rowHeight: CGFloat = 200.0
    
    // MARK: - Variables
    
    var companies: [Company] = []
    var showCompanyMethod: ((Company) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyTableViewCell
        let company = companies[indexPath.row]
        cell.setCompany(company: company)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = self.view.frame
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: headerHeight))
        view.backgroundColor = UIColor.clear
        
        let label = UILabel(frame: CGRect(x: 30, y: 12, width: 200, height: 50))
        label.text = "Discover"
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
        let company = companies[indexPath.row]
        showCompanyMethod?(company)
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
