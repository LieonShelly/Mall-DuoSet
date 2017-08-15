//
//  MustBuyRecommendData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MustBuyRecommendData.h"

@implementation MustBuyRecommendData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _list_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] : @"";
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@!750x300",BaseImgUrl,str];
            _headeCover = [NSString stringWithFormat:@"%@%@!256x200",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"summary"]) {
            _summary = [dic objectForKey:@"summary"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"summary"]] : @"";
        }
        if ([dic objectForKey:@"pv"]) {
            _pv = [dic objectForKey:@"pv"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"pv"]] : @"";
        }
        if ([dic objectForKey:@"shareCount"]) {
            _shareCount = [dic objectForKey:@"shareCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"shareCount"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
