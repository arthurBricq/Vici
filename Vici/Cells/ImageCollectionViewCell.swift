//
//  ImageCollectionViewCell.swift
//  Vici
//
//  Created by Arthur BRICQ on 06/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    public func setCell(legend: String, image: UIImage) {
        self.imageView.image = image
        self.imageView.contentMode = .scaleAspectFit
    }
    
    
}
