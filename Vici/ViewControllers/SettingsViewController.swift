//
//  SettingsViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var firstButton: NiceButton!
    @IBOutlet weak var secondButton: NiceButton!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Add icon to navigation controller bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "AppLogo")
        imageView.image = image
        navigationItem.titleView = imageView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !(UserDefaults.standard.bool(forKey: "hasAccount")) {
            usernameLabel.text = "You don't have an account"
            firstButton.text = "Create"
            emailLabel.isHidden = true
            secondButton.isHidden = true
        } else {
            usernameLabel.text = "Username : " + UserDefaults.standard.string(forKey: "username")!
            firstButton.text = "Change"
            emailLabel.text = "Email address : " + UserDefaults.standard.string(forKey: "emailAddress")!
            emailLabel.isHidden = false
            secondButton.isHidden = false
        }
    }
    
}
