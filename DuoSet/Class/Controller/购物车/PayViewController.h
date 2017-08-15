//
//  PayViewController.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/9.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PayWayStatusByCart,
    PayWayStatusBySingleItem,
    PayWayStatusByOrderList,
    PayWayStatusByOrderDetails
} PayWayStatus;

@interface PayViewController : UIViewController

-(instancetype)initWithPayWayStatus:(PayWayStatus)payStatus orderId:(NSString *)orderId;

@end
