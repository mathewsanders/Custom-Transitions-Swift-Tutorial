//
//  TransitionMananger.swift
//  Transitions
//
//  Created by Mathew Sanders on 9/5/14.
//  Copyright (c) 2014 Mat. All rights reserved.
//

import UIKit

class TransitionMananger: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    // MARK: UIViewControllerTransitioningDelegate methods
    
    // what UIViewControllerAnimatedTransitioning object to use for presenting
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return self
    }
    
    // what UIViewControllerAnimatedTransitioning object to use for presenting
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning!  {
        return self
    }
    
    // MARK: UIViewControllerAnimatedTransitioning methods
    
    // return how many seconds the transition animation should take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval  {
        return 0.5
    }
    
    // perform the animation(s) to show the transition from one screen to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        // TODO: we still need to define the animation
    }
    
}
