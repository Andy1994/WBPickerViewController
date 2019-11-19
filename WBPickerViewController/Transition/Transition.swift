//
//  Transition.swift
//  tantan-x
//
//  Created by wangwenbo on 2019/4/15.
//  Copyright © 2019 Tantan. All rights reserved.
//

import UIKit

protocol CustomTransitionAnimation: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
    var presentDuration: TimeInterval { get }
    var dismissDuration: TimeInterval { get }
    func presentTransitionAnimation() -> CustomTransitionAnimation
    func dismissTransitionAnimation() -> CustomTransitionAnimation
}

extension CustomTransitionAnimation {
    var presentDuration: TimeInterval {
        get { return 0 }
    }
    
    var dismissDuration: TimeInterval {
        get { return 0 }
    }
    
    func presentTransitionAnimation() -> CustomTransitionAnimation {
        isPresenting = true
        return self
    }
    
    func dismissTransitionAnimation() -> CustomTransitionAnimation {
        isPresenting = false
        return self
    }
}

class Transition: NSObject, UIViewControllerTransitioningDelegate {
    
    private var animation: CustomTransitionAnimation
    
    init(animation: CustomTransitionAnimation) {
        self.animation = animation
        super.init()
    }
    
    class func alertTransition() -> Transition {
        return Transition(animation: AlertTransitionAnimation())
    }
    
    // MARK:- UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animation.presentTransitionAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animation.dismissTransitionAnimation()
    }
}
