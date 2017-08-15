//
//  ProductDetailsSeckillData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailsSeckillData.h"

@implementation ProductDetailsSeckillData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"endTime"]) {
            _endTime = [dic objectForKey:@"endTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"endTime"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _robId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"robPrice"]) {
            NSString *str = [dic objectForKey:@"robPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robPrice"]] : @"";
            _robPrice = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"startTime"]) {
            _startTime = [dic objectForKey:@"startTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"startTime"]] : @"";
        }
        if ([dic objectForKey:@"systemTime"]) {
            _systemTime = [dic objectForKey:@"systemTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"systemTime"]] : @"";
        }
        if ([dic objectForKey:@"buyCount"]) {
            _buyCount = [dic objectForKey:@"buyCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"buyCount"]] : @"";
        }
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
