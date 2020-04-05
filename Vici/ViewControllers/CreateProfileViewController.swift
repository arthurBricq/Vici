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
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var createAccountButton: NiceButton!
    @IBOutlet weak var bottomPhrase: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    @IBOutlet var creatingOutlets: [Any]!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var middleConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    var isCreating = true
    
    // actions
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        if isCreating {
            var errorMsg = ""
            
            let username = usernameField.text!
            if (username == "") {
                animateError(for: self.usernameField)
                errorMsg = "Username cannot be empty"
            }
            
            let email = emailField.text!
            if (!validateEmail(enteredEmail: email)) {
                animateError(for: self.emailField)
                if (errorMsg == "") {
                    errorMsg = "Email adress incorrect"
                } else {
                    errorMsg = "Multiple fields are incorrect"
                }
            }
            
            let password = passwordField.text!
            if (!validatePassword(password: password)) {
                animateError(for: self.passwordField)
                animateError(for: self.confirmPasswordField)
                if (errorMsg == "") {
                    errorMsg = "Respect password rules"
                } else {
                    errorMsg = "Multiple fields are incorrect"
                }
            }
            
            let confirmed = confirmPasswordField.text!
            if (confirmed != password) {
                animateError(for: self.confirmPasswordField)
                animateError(for: self.confirmPasswordField)
                if (errorMsg == "") {
                    errorMsg = "Two different passwords"
                } else {
                    errorMsg = "Multiple fields are incorrect"
                }
            }
            
            if (!checkerButton.isChecked) {
                animateError(for: self.conditionLabel)
                if (errorMsg == "") {
                    errorMsg = "You need to accept conditions"
                } else {
                    errorMsg = "Multiple fields are incorrect"
                }
            }
            
            if (errorMsg != "") {
                createAccountButton.text = errorMsg
            } else {
                
                // We can create the account here with the infos
                if (accountManager.sentPostToCreate(username: username, email: email, password: password)) {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    animateError(for: self.usernameField)
                    animateError(for: self.emailField)
                    animateError(for: self.passwordField)
                    animateError(for: self.confirmPasswordField)
                    createAccountButton.text = "There is an error"
                }
                
            }
        } else {
            let username = usernameField.text!
            let password = passwordField.text!
            
            if (username == "" || password == "") {
                animateError(for: self.usernameField)
                animateError(for: self.passwordField)
                createAccountButton.text = "Username or password empty"
            } else {
                if (accountManager.sendPostToConnect(username: username, password: password)) {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    animateError(for: self.usernameField)
                    animateError(for: self.passwordField)
                    createAccountButton.text = "Username or password incorrect"
                }
            }
        }
    }
    
    // Make the view wiggle a little to give a feedback to the user
    func animateError(for view: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            view.bounds.size.width += 20
        })
    }
    
    // Code to check if email is correct found here https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    // check if the password respect our criteria
    func validatePassword(password: String) -> Bool {
        if (password.count < 8) {
            return false
        }
        var countUpper = 0
        var countLower = 0
        for letter in password {
            if (letter.isUppercase) { countUpper += 1 }
            if (letter.isLowercase) { countLower += 1 }
        }
        if (countUpper == 0 || countLower == 0) {
            return false
        }
        return true
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            for subview in self.mainView.subviews {
                subview.alpha = 0
            }
            self.navigationItem.title = (self.isCreating ? "Create your account" : "Login")
        }) { (_) in
            self.isCreating = !self.isCreating
            for outlet in self.creatingOutlets {
                let viewOutlet = outlet as! UIView
                viewOutlet.isHidden = !self.isCreating
            }
            if (self.isCreating) {
                self.bottomPhrase.text = "You already have an account?"
                self.changeButton.setTitle("Login", for: .normal)
                self.createAccountButton.text = "Create an account"
                self.topConstraint.constant = 30
                self.middleConstraint.constant = 15
                self.bottomConstraint.constant = 15
            } else {
                self.bottomPhrase.text = "You don't have an account?"
                self.changeButton.setTitle("Create account", for: .normal)
                self.createAccountButton.text = "Login"
                self.topConstraint.constant = 150
                self.middleConstraint.constant = -60
                self.bottomConstraint.constant = 120
            }
            
            UIView.animate(withDuration: 0.25) {
                for subview in self.mainView.subviews {
                    subview.alpha = 1
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.layer.cornerRadius = 20
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        mainView.addGestureRecognizer(tap)
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}
