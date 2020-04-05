//
//  ButtonWithLogo.swift
//  Vici
//
//  Created by Marin on 05/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class ButtonWithLogo: UIButton {

    var isChecked = false
    @IBInspectable var name = "Category"
    @IBInspectable var mainColor: UIColor = UIColor(red: 0.011, green: 0.454, blue: 0.218, alpha: 1.000)
    @IBInspectable var secondColor: UIColor = UIColor(red: 0.837, green: 0.917, blue: 0.855, alpha: 1.000)
    private var logoView: UIImageView
    
    init(frame: CGRect, isCompanyCategory: Bool, number: Int) {
        
        logoView = UIImageView()
        logoView.image = UIImage(contentsOfFile: "HouseLogo")
        
        super.init(frame: frame)
        
        let logoViewWidth = 10/31 * frame.size.width
        let x = frame.size.width/2 - logoViewWidth/2
        let minYText = 14/31 * frame.size.height
        let y = minYText - 11
        
        logoView.frame = CGRect(x: x, y: y, width: logoViewWidth, height: logoViewWidth)
        self.addSubview(logoView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        CheckedButtonLogo.drawCheckedButtonWithLogo(frame: rect, resizing: .aspectFill, isSelected: isChecked, categoryName: name, mainColor: mainColor, secondColor: secondColor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.alpha = 0.4
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
        }
        isChecked = !isChecked
        self.setNeedsDisplay()
    }
}

public class CheckedButtonLogo : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawCheckedButtonWithLogo(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 31, height: 21), resizing: ResizingBehavior = .aspectFit, isSelected: Bool = false, categoryName: String = "Category", mainColor: UIColor = UIColor(red: 0.011, green: 0.454, blue: 0.218, alpha: 1.000), secondColor: UIColor = UIColor(red: 0.837, green: 0.917, blue: 0.855, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 31, height: 21), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 31, y: resizedFrame.height / 21)


        //// Variable Declarations
        let fillColor = isSelected ? mainColor : secondColor
        let textColor = isSelected ? secondColor : mainColor

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0.5, y: 0.5, width: 30, height: 20), cornerRadius: 5)
        fillColor.setFill()
        rectanglePath.fill()
        mainColor.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()


        //// Text Drawing
        let textRect = CGRect(x: 2, y: 14, width: 27, height: 4)
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [
            .font: UIFont.systemFont(ofSize: 3),
            .foregroundColor: textColor,
            .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]

        let textTextHeight: CGFloat = categoryName.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        categoryName.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
        
        context.restoreGState()

    }




    @objc(CheckedButtonLogoResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
