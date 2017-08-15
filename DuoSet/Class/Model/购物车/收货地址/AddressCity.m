//
//  AddressCity.m
//  DuoSet
//
//  Created by mac on 2017/1/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AddressCity.h"

@implementation AddressCity
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"areaName"]) {
            _cityName = [dic objectForKey:@"areaName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"areaName"]] : @"";
        }
        if ([dic objectForKey:@"counties"]) {
            if ([[dic objectForKey:@"counties"] isKindOfClass:[NSArray class]]) {
                NSArray *items = [dic objectForKey:@"counties"];
                _counties = [NSMutableArray array];
                for (NSDictionary *d in items) {
                    AddressCounty *item = [AddressCounty dataForDictionary:d];
                    [_counties addObject:item];
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
