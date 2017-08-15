//
//  TransitionAnimator.h
//  DuoSet
//
//  Created by lieon on 2017/6/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransitionAnimator : NSObject<UIViewControllerTransitioningDelegate
, UIViewControllerAnimatedTransitioning
>
@property(nonatomic, assign) BOOL isPresent;
@property(nonatomic, assign) CGRect presentFrame;
@end
