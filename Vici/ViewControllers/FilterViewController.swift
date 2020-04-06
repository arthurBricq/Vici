//
//  FilterViewController.swift
//  Vici
//
//  Created by Marin on 05/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet var buttonOutlets: [UIButton]!
    
    // MARK: - Variables
    var distance: Int = 40
    var filterCategorySelected: Int = 11
    
    // MARK: - Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImageColorableForAll()
        
        let x = Float(log(0.01718*Double(distance) + 1))
        distanceSlider.setValue(x, animated: false)
        distanceLabel.text = distance.description + " km"
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let parentMapVC = parent as? MapViewController {
            print("a")
            parentMapVC.distance = distance
            parentMapVC.filterCategorySelected = filterCategorySelected
        }
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        // calculate the distance from the slider with an exponential to get more precision on small value
        let distanceCalcul = (exp(distanceSlider.value) - 1) * 58.2
        distance = Int(distanceCalcul)
        if distance == 0 {
            distance = 1
        }
        distanceLabel.text = distance.description + " km"
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let button = sender as! UIButton
        let lastButton = buttonOutlets[filterCategorySelected]
        
        lastButton.tintColor = UIColor.black
        filterCategorySelected = button.tag
        button.tintColor = UIColor.blue
    }
    
    /// This function has to be called when view appear to make the image of the buttons colorable
    func setImageColorableForAll() {
        for i in 0..<buttonOutlets.count {
            let image = buttonOutlets[i].backgroundImage(for: .normal)?.withRenderingMode(.alwaysTemplate)
            buttonOutlets[i].setBackgroundImage(image, for: .normal)
            if i == filterCategorySelected {
                buttonOutlets[i].tintColor = UIColor.blue
            } else {
                buttonOutlets[i].tintColor = UIColor.black
            }
        }
    }
    
}
