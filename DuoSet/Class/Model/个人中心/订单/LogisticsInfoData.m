//
//  LogisticsInfoData.m
//  DuoSet
//
//  Created by fanfans on 2017/4/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "LogisticsInfoData.h"

@implementation LogisticsInfoData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"trace"]) {
            _trace = [NSMutableArray array];
            if ([[dic objectForKey:@"trace"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"trace"];
                for (NSDictionary *d in arr) {
                    TraceData *item = [TraceData dataForDictionary:d];
                    [_trace addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"express"]) {
            if ([[dic objectForKey:@"express"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *expressDic = [dic objectForKey:@"express"];
                if ([expressDic objectForKey:@"orderNo"]) {
                    _orderNo = [expressDic objectForKey:@"orderNo"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[expressDic objectForKey:@"orderNo"]] : @"";
                }
                if ([expressDic objectForKey:@"express"]) {
                    _express = [expressDic objectForKey:@"express"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[expressDic objectForKey:@"express"]] : @"";
                }
                if ([expressDic objectForKey:@"expressNum"]) {
                    _expressNum = [expressDic objectForKey:@"expressNum"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[expressDic objectForKey:@"expressNum"]] : @"";
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
