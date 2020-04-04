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
    
    // actions
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        
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
            
        }
        
    }
    
    // Make the view wiggle a little to gie a feedback to the user
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
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    @IBAction func facebookButtonTapped(_ sender: Any) {
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        dismiss(animated: true)
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
