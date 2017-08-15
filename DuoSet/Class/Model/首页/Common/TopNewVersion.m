//
//  TopNewVersion.m
//  DuoSet
//
//  Created by fanfans on 2017/4/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TopNewVersion.h"

@implementation TopNewVersion

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"appExplain"]) {
            _appExplain = [dic objectForKey:@"appExplain"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"appExplain"]] : @"";
        }
        if ([dic objectForKey:@"appType"]) {
            _appType = [dic objectForKey:@"appType"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"appType"]] : @"";
        }
        if ([dic objectForKey:@"createTime"]) {
            _createTime = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
        }
        if ([dic objectForKey:@"version"]) {
            _version = [dic objectForKey:@"version"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"version"]] : @"";
        }
        if ([dic objectForKey:@"url"]) {
            _url = [dic objectForKey:@"url"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]] : @"";
        }
        if ([dic objectForKey:@"forcedUpdating"]) {
            NSString *str = [dic objectForKey:@"forcedUpdating"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"forcedUpdating"]] : @"0";
            _forcedUpdating = str.integerValue == 1;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


@end
