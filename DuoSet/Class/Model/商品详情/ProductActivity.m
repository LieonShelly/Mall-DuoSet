//
//  ProductActivity.m
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "ProductActivity.h"

@implementation ProductActivity

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"beginDate"]) {
            _beginDate = [dic objectForKey:@"beginDate"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"beginDate"]] : @"";
        }
        if ([dic objectForKey:@"endDate"]) {
            _endDate = [dic objectForKey:@"endDate"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"endDate"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _activityId = [dic objectForKey:@"id"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
