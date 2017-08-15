//
//  SevenDaySignData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SevenDaySignData.h"

@implementation SevenDaySignData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"day"]) {
            _day = [dic objectForKey:@"day"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"day"]] : @"";
        }
        if ([dic objectForKey:@"pointCount"]) {
            _pointCount = [dic objectForKey:@"pointCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"pointCount"]] : @"";
        }
        if ([dic objectForKey:@"isSign"]) {
            NSString *str = [dic objectForKey:@"isSign"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isSign"]] : @"0";
            _isSign = str.integerValue == 1;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


@end
