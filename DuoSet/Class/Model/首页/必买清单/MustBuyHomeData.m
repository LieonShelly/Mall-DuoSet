//
//  MustBuyHomeData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MustBuyHomeData.h"

@implementation MustBuyHomeData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"recommend"]) {
            if ([[dic objectForKey:@"recommend"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"recommend"];
                _recommend = [NSMutableArray array];
                for (NSDictionary *d in arr) {
                    MustBuyRecommendData *item = [MustBuyRecommendData dataForDictionary:d];
                    [_recommend addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"buyListType"]) {
            if ([[dic objectForKey:@"buyListType"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"buyListType"];
                _buyListType = [NSMutableArray array];
                for (NSDictionary *d in arr) {
                    MustBuyListTypeData *item = [MustBuyListTypeData dataForDictionary:d];
                    [_buyListType addObject:item];
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
