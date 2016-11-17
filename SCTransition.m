//
//  SCTransition.m
//  BantingAssistant
//
//  Created by 毛强 on 2016/11/14.
//  Copyright © 2016年 Sybercare. All rights reserved.
//

#import "SCTransition.h"

@interface SCTransition ()

@end

@implementation SCTransition
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.transitionType == SCPopTransition) {
        return 0.75f;
    }else if (self.transitionType == SCPushTransition){
        return 0.35f;
    }else if (self.transitionType == SCPopNative)
        return 0.35;
    {}
    return 0.75f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
 
    if (self.transitionType == SCPopTransition) {
        
        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] addSubview:toViewController.view];
        toViewController.view.alpha = 0;
        toViewController.tabBarController.tabBar.frame = CGRectMake(0, SCREEN_HEIGHT-toViewController.tabBarController.tabBar.frame.size.height, SCREEN_WIDTH, toViewController.tabBarController.tabBar.frame.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            fromViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            toViewController.tabBarController.tabBar.transform = CGAffineTransformIdentity;
        }];
    }else if (self.transitionType == SCPushTransition){
        
        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] addSubview:toViewController.view];
        toViewController.view.alpha = 1;
        toViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        fromViewController.tabBarController.tabBar.frame = CGRectMake(-SCREEN_WIDTH, SCREEN_HEIGHT-toViewController.tabBarController.tabBar.frame.size.height, SCREEN_WIDTH, toViewController.tabBarController.tabBar.frame.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            fromViewController.view.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            fromViewController.view.alpha = 1;
            toViewController.view.transform = CGAffineTransformIdentity;
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }else if (self.transitionType == SCPopNative){
        
        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        UIView *superView = toViewController.tabBarController.tabBar.superview;
        
        [[transitionContext containerView] addSubview:toViewController.view];
        [[transitionContext containerView] addSubview:toViewController.tabBarController.tabBar];
        [[transitionContext containerView] bringSubviewToFront:fromViewController.view];
        
        fromViewController.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        toViewController.tabBarController.tabBar.frame = CGRectMake(-SCREEN_WIDTH*0.25, SCREEN_HEIGHT-toViewController.tabBarController.tabBar.frame.size.height, SCREEN_WIDTH, toViewController.tabBarController.tabBar.frame.size.height);
        toViewController.view.frame = CGRectMake(-SCREEN_WIDTH*0.25, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toViewController.tabBarController.tabBar.frame = CGRectMake(0, SCREEN_HEIGHT-toViewController.tabBarController.tabBar.frame.size.height, SCREEN_WIDTH, toViewController.tabBarController.tabBar.frame.size.height);
            toViewController.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
            fromViewController.view.frame = CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
            
        } completion:^(BOOL finished) {
            
            [superView addSubview:toViewController.tabBarController.tabBar];
            [toViewController.tabBarController.tabBar.superview bringSubviewToFront:toViewController.tabBarController.tabBar];
            toViewController.view.transform = CGAffineTransformIdentity;
            fromViewController.view.transform = CGAffineTransformIdentity;
            toViewController.tabBarController.tabBar.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }

}
@end
