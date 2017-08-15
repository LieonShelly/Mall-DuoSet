//
//  PiazzaFansUserInfo.m
//  DuoSet
//
//  Created by fanfans on 2017/5/25.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaFansUserInfo.h"

@implementation PiazzaFansUserInfo

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"avastar"]) {
            NSString *str = [dic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"avastar"]] : @"";
            _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"concerns"]) {
            NSString *str = [dic objectForKey:@"concerns"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"concerns"]] : @"0";
            _concerns = str.integerValue == 1;
        }
        if ([dic objectForKey:@"id"]) {
            _userId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"nickName"]) {
            _nickName = [dic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
