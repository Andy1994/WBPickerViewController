//
//  AlertTransitionAnimation.swift
//  WBPickerViewController_Example
//
//  Created by wangwenbo on 2019/4/15.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class AlertTransitionAnimation: NSObject, CustomTransitionAnimation {
    
    var innerIsPresenting = false
    var isPresenting: Bool {
        get { return innerIsPresenting }
        set { innerIsPresenting = newValue }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? presentDuration : dismissDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)

        guard fromViewController != nil && toViewController != nil else {
            transitionContext.completeTransition(true)
            return
        }
        
        let containerView = transitionContext.containerView
        if isPresenting {
            containerView.addSubview(toViewController!.view)
            transitionContext.completeTransition(true)
        } else {
            transitionContext.completeTransition(true)
        }
    }
    
}
