//
//  Animator.m
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "Animator.h"
#import "BackgroundView.h"

@implementation Animator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    
    CGFloat scale = 3;
    CGFloat perspective = 0.6;
    scale = self.reverse ? 1/scale : scale;
    
    toViewController.view.transform = CGAffineTransformMakeScale(perspective/scale, perspective/scale);
    toViewController.view.alpha = 0;
    
    UIView *overlay = [BackgroundView defaultView].overlay;
    overlay.backgroundColor = [fromViewController backgroundViewOverlayColor];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.transform = CGAffineTransformMakeScale(1, 1);
        fromViewController.view.transform = CGAffineTransformMakeScale(scale, scale);
        fromViewController.view.alpha = 0;
        toViewController.view.alpha = 1;
        
        overlay.backgroundColor = [toViewController backgroundViewOverlayColor];
        
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        toViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}



@end
