//
//  CurDetailResponse.m
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CurDetailResponse.h"

@implementation CurDetailResponse

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"0";
        }
        if ([dic objectForKey:@"id"]) {
            _obj_id = [dic objectForKey:@"id"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            _price = [dic objectForKey:@"price"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
        }
        if ([dic objectForKey:@"propertyCollection"]) {
            _propertyCollection = [dic objectForKey:@"propertyCollection"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyCollection"]] : @"";
        }
        if ([dic objectForKey:@"propertyName"]) {
            _propertyName = [dic objectForKey:@"propertyName"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyName"]] : @"";
        }
        if ([dic objectForKey:@"repertoryId"]) {
            _repertoryId = [dic objectForKey:@"repertoryId"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"repertoryId"]] : @"";
        }
        if ([dic objectForKey:@"robCount"]) {
            _robCount = [dic objectForKey:@"robCount"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robCount"]] : @"";
        }
        if ([dic objectForKey:@"robDate"]) {
            _robDate = [dic objectForKey:@"robDate"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robDate"]] : @"";
        }
        if ([dic objectForKey:@"robId"]) {
            _robId = [dic objectForKey:@"robId"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robId"]] : @"";
        }
        if ([dic objectForKey:@"robPrice"]) {
            _robPrice = [dic objectForKey:@"robPrice"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robPrice"]] : @"";
        }
        if ([dic objectForKey:@"robSession"]) {
            _robSession = [dic objectForKey:@"robSession"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robSession"]] : @"";
        }
        if ([dic objectForKey:@"sellCount"]) {
            _sellCount = [dic objectForKey:@"sellCount"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"sellCount"]] : @"";
        }
        if ([dic objectForKey:@"surplusCount"]) {
            _surplusCount = [dic objectForKey:@"surplusCount"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"surplusCount"]] : @"";
        }
        if ([dic objectForKey:@"userRobCount"]) {
            _surplusCount = [dic objectForKey:@"userRobCount"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"userRobCount"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
