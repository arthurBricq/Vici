//
//  CompanyViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {

    // MARK: - Constants
    
    /// Stands for the height of the row of a service, within the servicesStackView
    let serviceHeight: CGFloat = 40
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var coverImateView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet var serviceImageViews: [UIImageView]!
    
    @IBOutlet weak var servicesStackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    
    
    // MARK: - Variables
    
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpServicesStackView()
        
        // 1. Set all the data
        if let company = company {
            company.setScreenWithSelf(titleLabel: titleLabel, bodyLabel: bodyLabel, coverImageView: coverImateView, logoImageView: logoImageView, serviceImageViews: serviceImageViews)
        }
        
        // 2. Set round logo image
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.width/2
        self.logoImageView.layer.borderColor = UIColor.gray.cgColor
        self.logoImageView.layer.borderWidth = 1.0
        
        // 3. Set up gradient
        let view = UIView(frame: coverImateView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        coverImateView.addSubview(view)
        coverImateView.bringSubviewToFront(view)
        
    }
    
    private func setUpServicesStackView() {
        
        // two things to do
        // 1. add one row for each service
        // 2. Update the overall height of the content view, so that it is not overbig
        
        let c = company!
        let services = c.services!
        let computedHeight = CGFloat(services.count) * (serviceHeight + servicesStackView.spacing)
        stackViewHeightConstraint.constant = computedHeight
        
        for s in services {
            let name = ServiceCategory(rawValue: s.category)!.getLogoName()
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: serviceHeight, height: serviceHeight)
            
            let stack = UIStackView(arrangedSubviews: [imageView])
            stack.axis = .horizontal
            self.servicesStackView.addArrangedSubview(stack)
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
