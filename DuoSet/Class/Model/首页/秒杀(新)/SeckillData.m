//
//  SeckillData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillData.h"

@implementation SeckillData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"robTopBanner"]) {
            if ([[dic objectForKey:@"robTopBanner"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *bannerDic = [dic objectForKey:@"robTopBanner"];
                _robTopBanner = [CurrentFashionData dataForDictionary:bannerDic];
            }
        }
        if ([dic objectForKey:@"robs"]) {
            _robs = [NSMutableArray array];
            if ([[dic objectForKey:@"robs"] isKindOfClass:[NSArray class]]) {
                NSArray *items = [dic objectForKey:@"robs"];
                for (NSDictionary *d in items) {
                    SeckillListData *item = [SeckillListData dataForDictionary:d];
                    [_robs addObject:item];
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
