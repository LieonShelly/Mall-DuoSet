//
//  ProductStandards.m
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "ProductStandards.h"

@implementation ProductStandards

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"items"]) {
            if ([[dic objectForKey:@"items"] isKindOfClass:[NSArray class]]) {
                NSArray *items = [dic objectForKey:@"items"];
                _items =[NSMutableArray array];
                for (NSDictionary *d in items) {
                    Standard *s = [Standard dataForDictionary:d];
                    [_items addObject:s];
                }
            }
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
