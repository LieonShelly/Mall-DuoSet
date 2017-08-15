//
//  GlobalHomeData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalHomeData.h"

@implementation GlobalHomeData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"globalMiddleBanner"]) {
            _globalMiddleBanner = [NSMutableArray array];
            if ([[dic objectForKey:@"globalMiddleBanner"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"globalMiddleBanner"];
                for (NSDictionary *d in arr) {
                    CurrentFashionData *item = [CurrentFashionData dataForDictionary:d];
                    [_globalMiddleBanner addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"globalTopBanner"]) {
            _globalTopBanner = [NSMutableArray array];
            if ([[dic objectForKey:@"globalTopBanner"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"globalTopBanner"];
                for (NSDictionary *d in arr) {
                    CurrentFashionData *item = [CurrentFashionData dataForDictionary:d];
                    [_globalTopBanner addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"globalList"]) {
            _globalList = [NSMutableArray array];
            if ([[dic objectForKey:@"globalList"] isKindOfClass:[NSArray class]]) {
                NSArray *items = [dic objectForKey:@"globalList"];
                for (NSDictionary *d in items) {
                    GlobalAreaData *item = [GlobalAreaData dataForDictionary:d];
                    [_globalList addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"productList"]) {
            _productList = [NSMutableArray array];
            if ([[dic objectForKey:@"productList"] isKindOfClass:[NSArray class]]) {
                NSArray *items = [dic objectForKey:@"productList"];
                for (NSDictionary *d in items) {
                    ProductForListData *item = [ProductForListData dataForDictionary:d];
                    [_productList addObject:item];
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
