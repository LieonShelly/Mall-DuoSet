//
//  OrderRefundController.h
//  DuoSet
//
//  Created by fanfans on 2017/6/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"
#import "DuojiOrderData.h"

typedef void(^RefundSucceedBlock)();

@interface OrderRefundController : BaseViewController

-(instancetype)initWithDuojiOrderData:(DuojiOrderData *)order;

@property(nonatomic,copy) RefundSucceedBlock refundHandle;

@end
