//
//  BaseViewController.m
//  DuoSet
//
//  Created by fanfans on 12/26/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushController:(UIViewController *)VC titleName:(NSString *)titleName{
    VC.title = titleName;
    VC.view.backgroundColor = LGBgColor;
    UIBarButtonItem *leftReturnButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_nav_arrow_black"] style:UIBarButtonItemStylePlain target:self action:@selector(progressLeftReturnButton)];
    leftReturnButton.tintColor = [UIColor darkGrayColor];
    VC.navigationItem.leftBarButtonItem = leftReturnButton;
    [self.navigationController pushViewController:VC animated:YES];
}

/**导航栏左侧返回按钮事件监听*/
- (void)progressLeftReturnButton
{
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
