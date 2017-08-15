//
//  TadayNewItemTypeData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TadayNewItemTypeData.h"

@implementation TadayNewItemTypeData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"todayNewTopBanner"]) {
            if ([[dic objectForKey:@"todayNewTopBanner"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *bannerDic = [dic objectForKey:@"todayNewTopBanner"];
                _todayNewTopBanner = [CurrentFashionData dataForDictionary:bannerDic];
            }
        }
        if ([dic objectForKey:@"todayNewTypes"]) {
            _todayNewTypes = [NSMutableArray array];
            if ([[dic objectForKey:@"todayNewTypes"] isKindOfClass:[NSArray class]]) {
                NSArray *itemArr = [dic objectForKey:@"todayNewTypes"];
                for (NSDictionary *d in itemArr) {
                    TodayNewType *item = [TodayNewType dataForDictionary:d];
                    [_todayNewTypes addObject:item];
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
