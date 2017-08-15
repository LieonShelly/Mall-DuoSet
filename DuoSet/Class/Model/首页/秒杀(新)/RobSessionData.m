//
//  RobSessionData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RobSessionData.h"

@implementation RobSessionData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"isInRob"]) {
            NSString *str = [dic objectForKey:@"isInRob"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isInRob"]] : @"0";
            _isInRob = str.integerValue == 1;
        }
        if ([dic objectForKey:@"isCurrentDay"]) {
            _isCurrentDay = [dic objectForKey:@"isCurrentDay"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isCurrentDay"]] : @"0";
        }
        if ([dic objectForKey:@"robSession"]) {
            _robSession = [dic objectForKey:@"robSession"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robSession"]] : @"";
        }
        if ([dic objectForKey:@"countDown"]) {
            _countDown = [dic objectForKey:@"countDown"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"countDown"]] : @"";
        }
        if ([dic objectForKey:@"robSessionDisplay"]) {
            _robSessionDisplay = [dic objectForKey:@"robSessionDisplay"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robSessionDisplay"]] : @"";
        }
        if ([dic objectForKey:@"robSessionName"]) {
            _robSessionName = [dic objectForKey:@"robSessionName"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robSessionName"]] : @"";
        }
        if ([dic objectForKey:@"robTopBanners"]) {
            _robTopBanners = [NSMutableArray array];
            if ([[dic objectForKey:@"robTopBanners"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"robTopBanners"];
                for (NSDictionary *d in arr) {
                    HomeTopBanner *item = [HomeTopBanner dataForDictionary:d];
                    [_robTopBanners addObject:item];
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
