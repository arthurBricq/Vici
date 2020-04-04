//
//  CompanyTableViewCell.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    // MARK: - Variable
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCompany(company c: Company) {
        self.titleLabel.text = c.name
        self.bodyLabel.text = c.description
    }

}
