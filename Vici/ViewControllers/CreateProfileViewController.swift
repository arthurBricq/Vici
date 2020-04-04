//
//  CreateProfileViewController.swift
//  Vici
//
//  Created by Marin on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UITextFieldDelegate {

    // outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var checkerButton: CheckerButton!
    
    
    // actions
    @IBAction func createAccountButtonTapped(_ sender: Any) {
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    @IBAction func facebookButtonTapped(_ sender: Any) {
    }
    @IBAction func skipButtonTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.layer.cornerRadius = 20
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
