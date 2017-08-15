//
//  ChoiceSuperior.m
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "ChoiceSuperior.h"

@implementation ChoiceSuperior

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"coverImg"]) {
        }
        if ([dic objectForKey:@"id"]) {
            _itemId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"img"]) {
        }
        if ([dic objectForKey:@"products"]) {
            if ([[dic objectForKey:@"products"] isKindOfClass:[NSArray class]]) {
                NSArray *products = [dic objectForKey:@"products"] ;
                _products = [NSMutableArray array];
                for (NSDictionary *d in products) {
                    ChoiceSuperiorProduct *item = [ChoiceSuperiorProduct dataForDictionary:d];
                    [_products addObject:item];
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
