//
//  SCTransition.m
//  BantingAssistant
//
//  Created by 毛强 on 2016/11/14.
//  Copyright © 2016年 Sybercare. All rights reserved.
//

#import "SCTransition.h"

@implementation SCTransition
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.transitionType == SCPopTransition) {
        return 0.75f;
    }else if (self.transitionType == SCPushTransition){
        return 0.35f;
    }
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
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
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
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }

}
@end
