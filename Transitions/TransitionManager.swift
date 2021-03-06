//
//  TransitionManager.swift
//  Transitions
//
//  Created by Mathew Sanders on 9/5/14.
//  Copyright (c) 2014 Mat. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    private var presenting = true
    
    // MARK: UIViewControllerTransitioningDelegate methods
    
    // what UIViewControllerAnimatedTransitioning object to use for presenting
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        self.presenting = true
        return self
    }
    
    // what UIViewControllerAnimatedTransitioning object to use for presenting
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning!  {
        self.presenting = false
        return self
    }
    
    // MARK: UIViewControllerAnimatedTransitioning methods
    
    // return how many seconds the transition animation should take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval  {
        return 0.75
    }
    
    // perform the animation(s) to show the transition from one screen to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        
        // get reference to the container view that we should perform the transition in
        let container = transitionContext.containerView()!
        
        container.backgroundColor = UIColor.blackColor()
        
        // get references to our 'from' and 'to' view controllers
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        // get references to the root views of both controllers
        // we should be able to use transitionContext.viewForKey(UITransitionContextFromViewKey)! but this is a current bug is iOS 8 beta releases
        let fromView = fromViewController.view
        let toView = toViewController.view
        
        // set up from 2D transforms that we'll use in the animation
        let π : CGFloat = 3.14159265359
        
        let offScreenRotateIn = CGAffineTransformMakeRotation(-π/2)
        let offScreenRotateOut = CGAffineTransformMakeRotation(π/2)
        
        // set the start location of toView depending if we're presenting or not
        toView.transform = self.presenting ? offScreenRotateIn : offScreenRotateOut
        
        // set the anchor point so that rotations happen from the top-left corner
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(transitionContext)
        
        // perform the animation!
        // for this example, just slide the both fromView and toView from left to right at the same time
        // using usingSpringWithDamping for a little bounce
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: nil, animations: {
            
            // set the end location of fromView depending if we're presenting or not
            fromView.transform = self.presenting ? offScreenRotateOut : offScreenRotateIn
            toView.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                
                // add the toView back to the window
                // iOS is supposed to do this automatically but is a known bug in iOS 8 beta releases
                // in the future iOS should do this for us automatically
                // http://openradar.appspot.com/radar?id=5320103646199808
                UIApplication.sharedApplication().keyWindow!.addSubview(toView)
                
            })
    }
   
}
