//
//  FastLoginViewController.h
//  DuoSet
//
//  Created by lieon on 2017/6/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Handler)(void);
@interface FastLoginViewController : UIViewController
@property(nonatomic, copy) Handler fastLoginSuccess;
@property(nonatomic, copy) NSString * phoneNum;
@end
