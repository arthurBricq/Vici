//
//  CommentViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 06/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITextFieldDelegate {

    var id: Int?
    var completion: (() -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet var starsOutlets: [UIButton]!
    
    var amountOfStars = 3
    
    // MARK: - Functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alertIfNoAccount()
        
        colorStars()
        
        commentTextView.layer.borderColor = UIColor.gray.cgColor
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.cornerRadius = 10
        
        titleField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func alertIfNoAccount() {
        if UserDefaults.standard.bool(forKey: "hasAccount") == false {
            
            let alert = UIAlertController(title: "You don't have an account", message: "Or you are not connected but you need one to comment", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true)
            
        }
    }

    @IBAction func starsTouched(_ sender: Any) {
        if let button = sender as? UIButton {
            amountOfStars = button.tag + 1
            colorStars()
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if (titleField.text == "") {
            animateError(for: titleField)
        } else if (commentTextView.text == "") {
            animateError(for: commentTextView)
        } else {
            // Send comment to data base
            let am = AccountManager()
            am.sendPostToComment(companyId: self.id ?? 0, message: commentTextView.text, stars: amountOfStars)
            self.completion?()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func colorStars() {
        for i in 0..<amountOfStars {
            starsOutlets[i].setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
        for i in amountOfStars..<5 {
            starsOutlets[i].setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    /// Make the view wiggle a little to give a feedback to the user
    func animateError(for view: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            view.bounds.size.width += 20
        })
    }
    
}
