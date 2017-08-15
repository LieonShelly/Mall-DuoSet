//
//  AddressProvinceData.m
//  DuoSet
//
//  Created by mac on 2017/1/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AddressProvinceData.h"

@implementation AddressProvinceData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"areaName"]) {
            _provinceName = [dic objectForKey:@"areaName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"areaName"]] : @"";
        }
        if ([dic objectForKey:@"cities"]) {
            if ([[dic objectForKey:@"cities"] isKindOfClass:[NSArray class]]) {
                NSArray * cities = [dic objectForKey:@"cities"];
                _cities = [NSMutableArray array];
                for (NSDictionary *d in cities) {
                    AddressCity *item = [AddressCity dataForDictionary:d];
                    [_cities addObject:item];
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
