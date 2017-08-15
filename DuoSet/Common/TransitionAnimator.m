//
//  TransitionAnimator.m
//  DuoSet
//
//  Created by lieon on 2017/6/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TransitionAnimator.h"
#import "MoPopoverPresentationVC.h"

@interface TransitionAnimator()

@end

@implementation TransitionAnimator

-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    MoPopoverPresentationVC * pc = [[MoPopoverPresentationVC alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    pc.presentFrame = self.presentFrame;
    return pc;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresent = true;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresent = false;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresent) {
        UIView * toVIew = [transitionContext viewForKey:UITransitionContextToViewKey];
        [transitionContext.containerView addSubview:toVIew];
        toVIew.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVIew.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:true];
        }];
    } else {
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.transform = CGAffineTransformMakeScale(1, 0.1);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:true];
        }];
    }
}
@end
