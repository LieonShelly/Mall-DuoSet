//
//  AddressCounty.m
//  DuoSet
//
//  Created by mac on 2017/1/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AddressCounty.h"

@implementation AddressCounty

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"areaName"]) {
            _countyName = [dic objectForKey:@"areaName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"areaName"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
