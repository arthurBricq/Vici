//
//  SettingsViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Try to load an image and then to display it !
        
        let url = URL(string: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg")!
        let imageLoader = ImageLoader()
        imageLoader.downloadImage(from: url) { (image) in
            if let image = image {
                self.imageView.image = image
            } else {
                print("DATA ERROR ON GETTING IMAGE")
            }
        }
        
        
        // Check if the app was already launched
        let hasLaunchBefore = UserDefaults.standard.bool(forKey: "hasLaunchBefore")
        if !hasLaunchBefore {
            UserDefaults.standard.set(true, forKey: "hasLaunchBefore")
            UserDefaults.standard.set(false, forKey: "hasAccount")
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
