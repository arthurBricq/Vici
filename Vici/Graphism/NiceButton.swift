//
//  NiceButton.swift
//  Vici
//
//  Created by Marin on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

@IBDesignable
class NiceButton: UIButton {
    
    @IBInspectable var color: UIColor = UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) { didSet { updateText() } }
    @IBInspectable var textColor: UIColor = UIColor.init(red: 0.25, green: 0.25, blue: 0.25, alpha: 1) { didSet { updateText() } }

    @IBInspectable var lineWidth: CGFloat = 1.0
    
    @IBInspectable var text: String = "" { didSet { updateText() } }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let dec = lineWidth/2
        let insideRect = CGRect(x: dec, y: dec, width: rect.width - 2*dec, height: rect.height - 2*dec)
        let path = UIBezierPath(roundedRect: insideRect, cornerRadius: 10.0)
        
        path.lineWidth = lineWidth
        color.setFill()
        
        path.fill()
        
    }
    
    func updateText() {
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel!.font = UIFont(name: "PingFangSC-Regular", size: 15)
        self.tintColor = color
        self.setNeedsDisplay()
    }

}
