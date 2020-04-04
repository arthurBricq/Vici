//
//  CompanyTableViewCell.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet var serviceImageViews: [UIImageView]!
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 1. Set up logo
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.width/2
        self.logoImageView.layer.borderColor = UIColor.gray.cgColor
        self.logoImageView.layer.borderWidth = 1.0
        
        // 2. Set up the gradient
        let view = UIView(frame: coverImageView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        coverImageView.addSubview(view)
        coverImageView.bringSubviewToFront(view)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCompany(company c: Company) {
        self.titleLabel.text = c.name
        self.bodyLabel.text = c.description
        
        // Set the icons on the main page
        if let services = c.services {
            var i: Int = 0
            for s in services {
                if let cat = ServiceCategory(rawValue: s.category) {
                    let name = cat.getLogoName()
                    if let image = UIImage(named: name) {
                        serviceImageViews[i].image = image
                    } else {
                        print("LOGO NAME ERROR WITH : ", name)
                    }
                    i = i + 1
                    if i > serviceImageViews.count {
                        break
                    }
                }
            }
        }
        
        // Set the cover image background
        if let images = c.images {
            if let cover = images.first(where: { (image) -> Bool in
                return image.legend == "cover"
            }) {
                // todo: change this when server connection is done
                self.coverImageView.image = UIImage(named: cover.image)
            }
        }
    }

}
