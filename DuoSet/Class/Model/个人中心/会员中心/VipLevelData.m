//
//  VipLevelData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "VipLevelData.h"

@implementation VipLevelData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"endValue"]) {
            NSString *str = [dic objectForKey:@"endValue"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"endValue"]] : @"";
            _endValue = str.longLongValue;
        }
        if ([dic objectForKey:@"startValue"]) {
            NSString *str = [dic objectForKey:@"startValue"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"startValue"]] : @"";
            _startValue = str.longLongValue;
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"level"]) {
            _level = [dic objectForKey:@"level"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"level"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
