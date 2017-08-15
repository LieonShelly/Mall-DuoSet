//
//  ProductPropertyDetails.m
//  DuoSet
//
//  Created by fanfans on 2017/3/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductPropertyDetails.h"

@implementation ProductPropertyDetails

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _selected = false;
        if ([dic objectForKey:@"addPrice"]) {
            _addPrice = [dic objectForKey:@"addPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"addPrice"]] : @"0";
        }
        if ([dic objectForKey:@"id"]) {
            _itemId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"select"]) {
            NSString *str = [dic objectForKey:@"select"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"select"]] : @"0";
            _selected = str.integerValue == 1;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
