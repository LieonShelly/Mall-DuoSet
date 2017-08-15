//
//  CustomNavController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/14.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "CustomNavController.h"

@interface CustomNavController ()

@end

@implementation CustomNavController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fd_fullscreenPopGestureRecognizer.enabled = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0){
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 30);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [backButton setImage:IMAGE_NAME(@"new_nav_arrow_black") forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void) backAction{
    [self popViewControllerAnimated:YES];
}

@end
