//
//  MoPopoverPresentationVC.m
//  DuoSet
//
//  Created by lieon on 2017/6/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MoPopoverPresentationVC.h"

@implementation MoPopoverPresentationVC

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        
    }
    return self;
}

- (void)containerViewWillLayoutSubviews {
    
    self.presentedView.frame = self.presentFrame;
    UIView * coverView = [[UIView alloc]init];
    coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    coverView.frame = UIScreen.mainScreen.bounds;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverAction)];
    coverView.userInteractionEnabled = true;
    [coverView addGestureRecognizer:tap];
    [self.containerView insertSubview:coverView atIndex:0];
}

#pragma mark - action
- (void)coverAction {
//    [self.presentedViewController dismissViewControllerAnimated:true completion:nil];
}
@end
