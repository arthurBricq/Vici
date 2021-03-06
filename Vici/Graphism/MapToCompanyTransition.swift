//
//  MapToCompanyTransition.swift
//  Vici
//
//  Created by Marin on 05/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class MapToCompanyTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval = 1
    var operation: UINavigationController.Operation = .push
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        if operation == .push {
            let toView = transitionContext.view(forKey: .to)!
            let fromVC = transitionContext.viewController(forKey: .from) as! MapViewController
        
            toView.frame = CGRect(x: 0, y: fromVC.mapView.frame.maxY, width: fromVC.view.bounds.width, height: fromVC.view.bounds.height)
            containerView.addSubview(toView)
            
            UIView.animate(withDuration: duration, animations: {
                toView.frame = CGRect(x: 0, y: 0, width: fromVC.view.bounds.width, height: fromVC.view.bounds.height)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        } else {
            let toView = transitionContext.view(forKey: .to)!
            let toVC = transitionContext.viewController(forKey: .to) as! MapViewController
            let fromView = transitionContext.view(forKey: .from)!
        
            toView.frame = CGRect(x: 0, y: 0, width: fromView.bounds.width, height: fromView.bounds.height)
            containerView.insertSubview(toView, belowSubview: fromView)
            
            UIView.animate(withDuration: duration, animations: {
                fromView.frame = CGRect(x: 0, y: toVC.mapView.frame.maxY, width: fromView.bounds.width, height: fromView.bounds.height)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
    

}
