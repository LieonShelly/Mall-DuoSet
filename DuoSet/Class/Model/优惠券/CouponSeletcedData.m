//
//  CouponSeletcedData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CouponSeletcedData.h"

@implementation CouponSeletcedData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"couponCodeId"]) {
            _couponCodeId = [dic objectForKey:@"couponCodeId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"couponCodeId"]] : @"";
        }
        if ([dic objectForKey:@"canSelected"]) {
            NSString *str = [dic objectForKey:@"canSelected"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"canSelected"]] : @"";
            _canSelected = str.integerValue == 1;
        }
        if ([dic objectForKey:@"selected"]) {
            NSString *str = [dic objectForKey:@"selected"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"selected"]] : @"";
            _selected = str.integerValue == 1;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
