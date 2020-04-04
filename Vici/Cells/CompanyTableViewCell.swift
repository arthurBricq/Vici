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
    @IBOutlet weak var downView: UIView!
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 1. Set up logo
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.width/2
        self.logoImageView.layer.borderColor = UIColor.gray.cgColor
        self.logoImageView.layer.borderWidth = 1.0
        
        // 2. Set up the gradient of the top
        let view = UIView(frame: coverImageView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        coverImageView.addSubview(view)
        coverImageView.bringSubviewToFront(view)
        
        // 3. Set up the gradient of the top
        let gradient2: CAGradientLayer = CAGradientLayer()
        gradient2.colors = [UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.clear.cgColor]
        gradient2.locations = [0.0 , 1.0]
        gradient2.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient2.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient2.frame = CGRect(x: 0.0, y: 0.0, width: self.downView.frame.size.width, height: self.downView.frame.size.height)
        self.downView.layer.insertSublayer(gradient2, at: 0)
        
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