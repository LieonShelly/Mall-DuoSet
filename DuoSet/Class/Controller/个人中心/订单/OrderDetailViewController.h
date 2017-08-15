//
//  OrderDetailViewController.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/6.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderHeaderView.h"
#import "OrderBottomView.h"
#import "DuoSetOrder.h"

#import "DuojiOrderData.h"

typedef void(^OrderCancelOrDeletedBlock)();

@interface OrderDetailViewController : BaseViewController

-(instancetype)initWithOrderNum:(NSString *)no;

@property(nonatomic,assign) BOOL isPopToTop;
@property(nonatomic,copy) OrderCancelOrDeletedBlock cancelOrDeletedHandle;

@end
