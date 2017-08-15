//
//  UserCenterMainData.m
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "UserCenterMainData.h"

@implementation UserCenterMainData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"collectCount"]) {
            _collectCount = [dic objectForKey:@"collectCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"collectCount"]] : @"0";
        }
        if ([dic objectForKey:@"balance"]) {
            _balance = [dic objectForKey:@"balance"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"balance"]] : @"0";
        }
        if ([dic objectForKey:@"vipLevel"]) {
            _vipLevel = [dic objectForKey:@"vipLevel"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"vipLevel"]] : @"";
        }
        if ([dic objectForKey:@"couponCodeCount"]) {
            _couponCodeCount = [dic objectForKey:@"couponCodeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"couponCodeCount"]] : @"";
        }
        if ([dic objectForKey:@"pointCount"]) {
            _pointCount = [dic objectForKey:@"pointCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"pointCount"]] : @"";
        }
        if ([dic objectForKey:@"orderCount"] && [[dic objectForKey:@"orderCount"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *orderCountDic = [dic objectForKey:@"orderCount"];
            if ([orderCountDic objectForKey:@"0"]) {
                _waitPayCount = [orderCountDic objectForKey:@"0"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[orderCountDic objectForKey:@"0"]] : @"0";
            }
            if ([orderCountDic objectForKey:@"20"]) {
                _waitResiveCount = [orderCountDic objectForKey:@"20"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[orderCountDic objectForKey:@"20"]] : @"0";
            }
            if ([orderCountDic objectForKey:@"-2"]) {
                _waitCommentCount = [orderCountDic objectForKey:@"-2"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[orderCountDic objectForKey:@"-2"]] : @"0";
            }
            if ([orderCountDic objectForKey:@"-3"]) {
                _allCount = [orderCountDic objectForKey:@"-3"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[orderCountDic objectForKey:@"-3"]] : @"0";
            }
            if ([orderCountDic objectForKey:@"-1"]) {
                _exchangeAndReturnCount = [orderCountDic objectForKey:@"-1"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[orderCountDic objectForKey:@"-1"]] : @"0";
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
