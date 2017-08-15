//
//  UserSignData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserSignData.h"

@implementation UserSignData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"signDays"]) {
            _signDays = [dic objectForKey:@"signDays"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"signDays"]] : @"";
        }
        if ([dic objectForKey:@"pointCount"]) {
            _pointCount = [dic objectForKey:@"pointCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"pointCount"]] : @"";
        }
        if ([dic objectForKey:@"signRemark"]) {
            _signRemark = [dic objectForKey:@"signRemark"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"signRemark"]] : @"";
        }
        if ([dic objectForKey:@"todayIsSign"]) {
            NSString *str = [dic objectForKey:@"todayIsSign"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"todayIsSign"]] : @"0";
            _todayIsSign = str.integerValue == 1;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
