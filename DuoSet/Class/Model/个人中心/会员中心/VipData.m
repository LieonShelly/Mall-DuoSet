//
//  VipData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "VipData.h"

@implementation VipData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"pointCount"]) {
            _pointCount = [dic objectForKey:@"pointCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"pointCount"]] : @"";
        }
        if ([dic objectForKey:@"vipValue"]) {
            NSString *str = [dic objectForKey:@"vipValue"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"vipValue"]] : @"";
            _vipValue = str.longLongValue;
        }
        if ([dic objectForKey:@"vipValueStr"]) {
            _vipValueStr = [dic objectForKey:@"vipValueStr"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"vipValueStr"]] : @"";
        }
        if ([dic objectForKey:@"vipLevel"]) {
            _vipLevel = [dic objectForKey:@"vipLevel"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"vipLevel"]] : @"";
        }
        if ([dic objectForKey:@"vipLevelName"]) {
            _vipLevelName = [dic objectForKey:@"vipLevelName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"vipLevelName"]] : @"";
        }
        if ([dic objectForKey:@"vipLevels"]) {
            _vipLevels = [NSMutableArray array];
            if ([[dic objectForKey:@"vipLevels"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"vipLevels"];
                for (NSDictionary *d in arr) {
                    VipLevelData *item = [VipLevelData dataForDictionary:d];
                    [_vipLevels addObject:item];
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
