//
//  SeletcedCouponController.h
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopCarSureData.h"

typedef void(^SeletcedBlock)(CGFloat,NSMutableArray *);

@interface SeletcedCouponController : BaseViewController

-(instancetype)initWithShopCarSureData:(ShopCarSureData *)dataItem;

@property(nonatomic,copy) SeletcedBlock chioceHandle;

@end
