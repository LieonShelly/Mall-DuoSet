//
//  ShopCarSureData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCarSureProduct.h"
#import "CouponInfoData.h"

@interface ShopCarSureData : NSObject

@property (nonatomic,copy) NSString *coupons;
@property (nonatomic,copy) NSString *totalPrice;
@property (nonatomic,copy) NSString *productPrice;
@property (nonatomic,copy) NSString *carrierPrice;
@property (nonatomic,copy) NSString *amountPrice;
@property (nonatomic,copy) NSString *cutPrice;
@property (nonatomic,copy) NSString *totalTaxPrice;
@property (nonatomic,copy) NSString *idCard;
@property (nonatomic,copy) NSString *trueName;
@property (nonatomic,assign) BOOL agreePropocol;
@property (nonatomic,strong) NSMutableArray *products;
@property (nonatomic,strong) NSMutableArray *couponCodeResponses;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
