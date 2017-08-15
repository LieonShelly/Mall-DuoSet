//
//  PaySucceedController.h
//  DuoSet
//
//  Created by fanfans on 2017/6/26.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayViewController.h"

@interface PaySucceedController : UIViewController

-(instancetype)initWithPayWayStatus:(PayWayStatus)payStatus orderId:(NSString *)orderId;

@end
