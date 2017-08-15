//
//  ProductPropertyData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductPropertyData.h"

@implementation ProductPropertyData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"childValues"]) {
            if ([[dic objectForKey:@"childValues"] isKindOfClass:[NSArray class]]) {
                NSArray *childValues = [dic objectForKey:@"childValues"];
                _childValues = [NSMutableArray array];
                for (NSDictionary *d in childValues) {
                    ProductPropertyDetails *item = [ProductPropertyDetails dataForDictionary:d];
                    [_childValues addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"id"]) {
            _property_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _propertyName = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
