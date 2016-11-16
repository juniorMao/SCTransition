//
//  SCTransition.h
//  BantingAssistant
//
//  Created by 毛强 on 2016/11/14.
//  Copyright © 2016年 Sybercare. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    SCPopTransition, //default
    SCPushTransition,
    
} SCTransitionType;

@interface SCTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) SCTransitionType transitionType;
@end
