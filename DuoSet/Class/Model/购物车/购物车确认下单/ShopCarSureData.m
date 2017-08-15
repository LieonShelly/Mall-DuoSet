//
//  ShopCarSureData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCarSureData.h"

@implementation ShopCarSureData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _agreePropocol = true;
        if ([dic objectForKey:@"coupons"]) {
            _coupons = [dic objectForKey:@"coupons"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"coupons"]] : @"0";
        }
        if ([dic objectForKey:@"idCard"]) {
            _idCard = [dic objectForKey:@"idCard"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"idCard"]] : @"";
        }
        if ([dic objectForKey:@"trueName"]) {
            _trueName = [dic objectForKey:@"trueName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"trueName"]] : @"";
        }
        if ([dic objectForKey:@"totalPrice"]) {
            NSString *priceStr = [dic objectForKey:@"totalPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPrice"]] : @"0";
            _totalPrice = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
        if ([dic objectForKey:@"productPrice"]) {
            NSString *priceStr = [dic objectForKey:@"productPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productPrice"]] : @"0";
            _productPrice = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
        if ([dic objectForKey:@"carrierPrice"]) {
            NSString *priceStr = [dic objectForKey:@"carrierPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"carrierPrice"]] : @"0";
            _carrierPrice = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
        if ([dic objectForKey:@"amountPrice"]) {
            NSString *priceStr = [dic objectForKey:@"amountPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"amountPrice"]] : @"0";
            _amountPrice = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
        if ([dic objectForKey:@"cutPrice"]) {
            NSString *priceStr = [dic objectForKey:@"cutPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cutPrice"]] : @"0";
            _cutPrice = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
        if ([dic objectForKey:@"totalTaxPrice"]) {
            NSString *priceStr = [dic objectForKey:@"totalTaxPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalTaxPrice"]] : @"0";
            _totalTaxPrice = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
        if ([dic objectForKey:@"products"]) {
            if ([[dic objectForKey:@"products"] isKindOfClass:[NSArray class]]) {
                NSArray *productsArr = [dic objectForKey:@"products"];
                _products = [NSMutableArray array];
                for (NSDictionary *d in productsArr) {
                    ShopCarSureProduct *item = [ShopCarSureProduct dataForDictionary:d];
                    [_products addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"couponCodeResponses"]) {
            if ([[dic objectForKey:@"couponCodeResponses"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"couponCodeResponses"];
                _couponCodeResponses = [NSMutableArray array];
                for (NSDictionary *d in arr) {
                    CouponInfoData *item = [CouponInfoData dataForDictionary:d];
                    [_couponCodeResponses addObject:item];
                }
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
